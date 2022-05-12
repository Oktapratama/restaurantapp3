import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../provider/list_provider.dart';
import '../widgets/platform_widget.dart';
import '../widgets/restaurant_list_card.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurants App'),
        trailing: Icon(CupertinoIcons.search),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
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

