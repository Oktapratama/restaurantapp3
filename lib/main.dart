import 'package:flutter/material.dart';
import 'package:restaurantapp/data/model/detail_restaurant.dart';
import 'package:restaurantapp/ui/restaurant_detail_page.dart';
import 'package:restaurantapp/widgets/restaurant_detail_card.dart';
import 'package:restaurantapp/ui/restaurant_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      },
    );
  }
}


