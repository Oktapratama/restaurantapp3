import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurantapp/data/api/service_api.dart';
import 'package:restaurantapp/provider/search_provider.dart';
import 'package:restaurantapp/widgets/restaurant_search_card.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController controller = TextEditingController();
  String output = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ServiceAPI()),
      child: Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.search,
                        size: 35,
                      ),
                      title: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Cari Disini...',
                            border: InputBorder.none,
                          ),
                          controller: controller,
                          onChanged: (String query) {
                            if (query.isNotEmpty) {
                              setState(() {
                                output = query;
                              });
                              state.fetchAllRestaurant(output);
                            }
                          }),
                    ),
                  ),
                  (output.isEmpty)
                      ? const Center(
                          child: Text('Silahkan lakukan pencarian...'),
                        )
                      : Consumer<RestaurantSearchProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.Loading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.state == ResultState.HasData) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.result!.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurant =
                                        state.result!.restaurants[index];
                                    return SearchCard(restaurant: restaurant);
                                  });
                            } else if (state.state == ResultState.NoData) {
                              return Center(child: Text(state.message));
                            } else if (state.state == ResultState.Error) {
                              return Center(child: Text(state.message));
                            } else {
                              return const Center(child: Text(''));
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
