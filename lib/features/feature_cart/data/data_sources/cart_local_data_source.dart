import 'dart:developer';

import 'package:path/path.dart';
import 'package:products_application/core/model/product.dart';
import 'package:products_application/features/feature_cart/data/mapper/cart_mapper.dart';
import 'package:sqflite/sqflite.dart';

/// Abstract interface for a local data source to manage cart data.
///
/// This class defines methods for adding, loading, and removing products
/// in/from the cart. It is intended to be implemented by a class that interacts
/// with a local storage mechanism (e.g., SQLite, Shared Preferences, etc.).
///
/// Methods:
/// - `addProductToCart`: Adds a product to the cart.
/// - `loadProductsInCart`: Loads all products currently in the cart.
/// - `removeProductFromCart`: Removes a specific product from the cart.
///
abstract interface class CartLocalDataSource {
  Future<void> addProductToCart({required Product product});
  Future<List<Product>> loadProductsInCart();
  Future<void> removeProductFromCart({required Product product});
}

/// Implementation of [CartLocalDataSource] that interacts with a local SQLite
/// database to manage cart data.
class CartLocalDataSourceImpl implements CartLocalDataSource {
  late Database _database;

  /// Initializes the SQLite database, if it is not already initialized.
  /// This method will create the 'cart' table on the first use.
  Future<void> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cart.db');

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        return db.execute(
          '''
 CREATE TABLE cart (
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          category TEXT,
          rating REAL,
          thumbnail TEXT,
          price REAL
        )
''',
        );
      },
    );
  }

  @override
  Future<void> addProductToCart({required Product product}) async {
    await _initDatabase();

    await _database.insert(
      'cart',
      CartMapper.toMap(product),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log("Successful added!");
  }

  @override
  Future<List<Product>> loadProductsInCart() async {
    await _initDatabase();

    final List<Map<String, dynamic>> maps = await _database.query('cart');
    log(List.generate(maps.length, (i) {
      return CartMapper.fromMap(maps[i]);
    }).toString());
    return List.generate(maps.length, (i) {
      return CartMapper.fromMap(maps[i]);
    });
  }

  @override
  Future<void> removeProductFromCart({required Product product}) async {
    await _initDatabase();
    int res = await _database.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [product.id],
    );
    if (res > 0) {
      log('Product deleted!');
    } else {
      log('No product found');
    }
  }
}
