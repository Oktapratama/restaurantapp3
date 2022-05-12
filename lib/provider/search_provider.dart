import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurantapp/data/api/service_api.dart';
import 'package:restaurantapp/data/model/search_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ServiceAPI apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchAllRestaurant(search);
  }

  ResultRestaurantsSearch? _restaurantResult;
  ResultState? _state;
  String _message = '';
  String _search = '';

  String get message => _message;

  ResultRestaurantsSearch? get result => _restaurantResult;

  String get search => _search;

  ResultState? get state => _state;

  Future<dynamic> fetchAllRestaurant(String search) async {
    try {
      if (search.isNotEmpty) {
        _state = ResultState.Loading;
        _search = search;
        notifyListeners();
        final restaurant = await apiService.searchingRestaurant(search);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.NoData;
          notifyListeners();
          return _message = 'Data tidak ada';
        } else {
          _state = ResultState.HasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      } else {
        return _message = 'text null';
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
      "tidak bisa terhubung, silahkan cek koneksi anda";
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}