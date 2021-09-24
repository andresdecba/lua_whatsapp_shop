import 'package:wappshop_2/models/models.dart';

class ProductsSingleton {
  static final ProductsSingleton _singleton = ProductsSingleton._internal();

  factory ProductsSingleton() {
    return _singleton;
  }

  ProductsSingleton._internal();

  //get getProduct => _getProducts;

  List<ProductModel> getProducts = [];
}

//You can construct it like this

// main() {
//   var s1 = Singleton();
//   var s2 = Singleton();
//   print(identical(s1, s2));  // true
//   print(s1 == s2);           // true
// }