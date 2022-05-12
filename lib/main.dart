import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/provider/favorite_provider.dart';
import 'package:restaurantapp/provider/scheduling_provider.dart';
import 'package:restaurantapp/ui/page_detail.dart';
import 'package:restaurantapp/ui/page_home.dart';
import 'package:restaurantapp/ui/page_setting.dart';
import 'package:restaurantapp/utils/background_service_restaurant.dart';
import 'package:restaurantapp/utils/notification_helper_restaurant.dart';
import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurantapp/utils/preferences_helper_restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/database_helper_restaurant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              idDetail: ModalRoute.of(context)!.settings.arguments == null
                  ? 'null'
                  : ModalRoute.of(context)!.settings.arguments as String),
          RestaurantSettingPage.routeName: (context) =>
              const RestaurantSettingPage(),
        },
      ),
    );
  }
}
