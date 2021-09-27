import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wappshop_2/models/product_model.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';

class ProductsProvider extends ChangeNotifier {
  // llamar todos los productos al iniciar
  ProductsProvider() {
    getAllProducts();
    getAboutScreen();
  }

  // propiedades
  ProductModel? singleProduct;
  bool isLoading = true;
  var products = ProductsSingleton();

  // database reference
  final _database = FirebaseDatabase.instance.reference();

  // streams
  late StreamSubscription<Event> _getSingleProductStream;
  late StreamSubscription<Event> _getAllProductsStream;

  // llamar a db UN SOLO producto
  Future<ProductModel?> getSingleProduct() async {
    _getSingleProductStream = _database.child("products/id").onValue.listen((event) {
      final dbResponse = Map<String, dynamic>.from(event.snapshot.value);
      singleProduct = ProductModel.fromMap(dbResponse);
      notifyListeners();
    });
    return singleProduct;
  }

  // llamar a db TODOS los prodcutos
  Future getAllProducts() async {
    try {
      _getAllProductsStream = _database.child("products/").onValue.listen((event) {
        final dbResponse = Map<String, dynamic>.from(event.snapshot.value);
        products.getProducts = dbResponse.values.map((orderAsJson) {
          return ProductModel.fromMap(Map<String, dynamic>.from(orderAsJson));
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print('Error al ontener los datos en $e');
    }
    return products;
  }

  // TODO: hacer modelo para subir y bajar la info de about
  // llamar a descripcion about screen
  Future getAboutScreen() async {
    _getSingleProductStream = _database.child("config/description").onValue.listen((event) {
      final dbResponse = event.snapshot.value.toString(); // Map<String, dynamic>.from(event.snapshot.value);

      print('::::::::: $dbResponse');
      //singleProduct = ProductModel.fromMap(dbResponse);
      notifyListeners();
    });
    //return dbResponse;
  }

  // cerrar streams
  @override
  void dispose() {
    _getSingleProductStream.cancel();
    _getAllProductsStream.cancel();
    super.dispose();
  }
}
