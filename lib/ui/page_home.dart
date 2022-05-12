import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/data/api/service_api.dart';
import 'package:restaurantapp/provider/list_provider.dart';
import 'package:restaurantapp/ui/page_favorite.dart';
import 'package:restaurantapp/ui/page_list.dart';
import 'package:restaurantapp/ui/page_search.dart';
import 'package:restaurantapp/ui/page_setting.dart';
import 'dart:io';

import '../data/database/database_helper_restaurant.dart';
import '../provider/favorite_provider.dart';
import '../provider/search_provider.dart';
import '../widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/page_home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _restoText = 'Restaurant';
  static const String _seacrhText = 'Search';
  static const String _favoriteText = 'Favorite';

  List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ServiceAPI()),
      child: RestaurantListPage(),
    ),
    ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ServiceAPI()),
      child: RestaurantSearchPage(),
    ),
    ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: RestaurantFavoritePage(),
    ),
    const RestaurantSettingPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.restaurant),
      label: _restoText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
      label: _seacrhText,
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS
          ? CupertinoIcons.square_favorites_alt
          : Icons.favorite),
      label: _favoriteText,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSettingPage.routeName);
            },
          )
        ],
      ),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
