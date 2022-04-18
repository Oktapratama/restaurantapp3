import 'dart:convert';

ResultRestaurantsSearch resultRestaurantsSearchFromJson(String str) =>
    ResultRestaurantsSearch.fromJson(json.decode(str));

String resultRestaurantsSearchToJson(ResultRestaurantsSearch data) =>
    json.encode(data.toJson());

class ResultRestaurantsSearch {
  ResultRestaurantsSearch({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantSearch> restaurants;

  factory ResultRestaurantsSearch.fromJson(Map<String, dynamic> json) =>
      ResultRestaurantsSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantSearch>.from(
            json["restaurants"].map((x) => RestaurantSearch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class RestaurantSearch {
  RestaurantSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}