import 'package:flutter/cupertino.dart';
import 'package:restaurantapp/data/model/list_restaurant.dart';

import '../common/constant.dart';
import '../data/database/database_helper_restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state = ResultState.Loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Data tidak ada';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}