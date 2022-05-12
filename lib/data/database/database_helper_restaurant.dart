import 'package:restaurantapp/data/model/list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _favoriteTable = 'Resto';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
    openDatabase('$path/restaurants.db', onCreate: (db, version) async {
      await db.execute('''Create Table $_favoriteTable (
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
          )''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    return _database ??= await _initializeDb();
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_favoriteTable, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favoriteTable);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _favoriteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
