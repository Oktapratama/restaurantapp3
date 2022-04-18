import 'package:flutter/material.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';
import '../ui/restaurant_detail_page.dart';


class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return RestaurantDetailPage(idDetail: restaurant.id);
        }));
      },
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
          "https://restaurant-api.dicoding.dev/images/medium/" +
              restaurant.pictureId,
        width: 100,
      ),
      title: Text(restaurant.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.redAccent,
                size: 18,
              ),
              Text(restaurant.city),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 18,
              ),
              Text("${restaurant.rating}"),
            ],
          ),
        ],
      ),
    );
  }
}
