import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/data/api/service_api.dart';
import 'package:restaurantapp/widgets/restaurant_detail_card.dart';

import '../common/constant.dart';
import '../provider/detail_provider.dart';
import '../widgets/platform_widget.dart';

class RestaurantDetailPage extends StatelessWidget {
static const routeName = '/resto_detail';
final String idDetail;
  const RestaurantDetailPage({Key? key, required this.idDetail}) : super(key: key);

  Widget _buildDetail() {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) =>
          DetailRestaurantProvider(apiService: ServiceAPI(), id: idDetail),
      child: Consumer<DetailRestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            final restaurants = state.result.restaurants;
            return DetailRestaurant(
              restaurant: restaurants,
            );
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.Error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }


  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants App'),
      ),
      body: _buildDetail(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurants App'),
        trailing: Icon(CupertinoIcons.search),
        transitionBetweenRoutes: false,
      ),
      child: _buildDetail(),
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

