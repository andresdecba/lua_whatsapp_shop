import 'package:wappshop_2/models/models.dart';

class ProductsSingleton {
  
  static final ProductsSingleton _singleton = ProductsSingleton._internal();

  factory ProductsSingleton() {
    return _singleton;
  }

  ProductsSingleton._internal();

  // propiedades
  List<ProductModel> getProducts = [];
}