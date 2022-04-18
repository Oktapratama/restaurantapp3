import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/detail_restaurant.dart';
import '../model/list_restaurant.dart';
import '../model/search_restaurant.dart';

class ServiceAPI {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  // Service API untuk Mendapatkan List Data
  Future<ResultRestaurantsList> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return ResultRestaurantsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mendapatkan Daftar Restoran');
    }
  }

  // Service API untuk Mendapatkan Detail Data
  Future<ResultRestaurantsDetail> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/$id'));
    if (response.statusCode == 200) {
      return ResultRestaurantsDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mendapatkan Detail Restoran');
    }
  }

  // Service API untuk Search Data
  Future<ResultRestaurantsSearch> searchingRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + 'search?q=$query'));
    if (response.statusCode == 200) {
      return ResultRestaurantsSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mendapatkan Hasil Pencarian');
    }
  }
}