import 'package:flutter/material.dart';
import '../data/model/detail_restaurant.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailRestaurant({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/" +
                    restaurant.pictureId,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Text(
                        "${restaurant.rating}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  SizedBox(height: 10),
                  Text('${restaurant.description}',
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            Text('Foods Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.food_bank,
                  color: Colors.redAccent,
                  size: 50,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: restaurant.menus.foods
                        .map((food) => Text(food.name))
                        .toList(),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Text('Drinks Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.local_drink,
                  color: Colors.redAccent,
                  size: 50,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: restaurant.menus.drinks
                        .map((drink) => Text(drink.name))
                        .toList(),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 8),
            Text('Review',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: restaurant.customerReviews
                        .map((review) => Column(
                              children: [
                                Row(
                                  children: [
                                    Text(review.name),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(review.review),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(review.date),
                                  ],
                                ),
                              ],
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
