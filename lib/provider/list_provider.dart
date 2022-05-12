import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurantapp/data/api/service_api.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ServiceAPI apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late ResultRestaurantsList _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ResultRestaurantsList get result => _listRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data tidak ada';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
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