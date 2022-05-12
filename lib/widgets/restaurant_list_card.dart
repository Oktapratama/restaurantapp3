import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';
import 'package:restaurantapp/provider/favorite_provider.dart';
import '../ui/page_detail.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavourited = snapshot.data ?? false;
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
              subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                  Column(
                    children: [
                      isFavourited == true  ? IconButton(
                          onPressed: () =>
                              provider.removeFavorite(
                                  restaurant.id),
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ))
                          : IconButton(
                          onPressed: () => provider
                              .addFavorite(restaurant),
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              ),
            );
          });
    });
  }
}
