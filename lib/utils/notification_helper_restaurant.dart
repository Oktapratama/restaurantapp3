import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';
import 'package:rxdart/subjects.dart';

import '../common/navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializeSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializeSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializeSettingsAndroid, iOS: initializeSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if (payload != null) {
            print('notification payload: ' + payload);
          }
          selectNotificationSubject.add(payload ?? 'empty payload');
        });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ResultRestaurantsList restaurants) async {
    var _channelId = "1";
    var _channelName = "channel_01";


    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var randomResto = restaurants
        .restaurants[Random().nextInt(restaurants.restaurants.length - 1)];
    var titleNotification = randomResto.name;
    var titleNews = randomResto.description;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurants.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
          (String payload) async {
        var data = ResultRestaurantsList.fromJson(json.decode(payload));
        var restaur = data.restaurants[0];
        Navigation.intentWithData(route, restaur);
      },
    );
  }
}