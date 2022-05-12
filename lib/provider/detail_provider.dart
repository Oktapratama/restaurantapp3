import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:restaurantapp/data/api/service_api.dart';
import 'package:restaurantapp/data/model/detail_restaurant.dart';

import '../common/constant.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ServiceAPI apiService;
  final String id;

  late ResultRestaurantsDetail _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurantProvider({required this.id, required this.apiService}) {
    getDetailRestaurant(id);
  }

  String get message => _message;
  ResultRestaurantsDetail get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data tidak ada';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
      "tidak bisa terhubung, silahkan cek koneksi anda";
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}