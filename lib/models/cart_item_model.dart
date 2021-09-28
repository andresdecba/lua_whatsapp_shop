import 'package:wappshop_2/models/product_model.dart';

class CartItemModel {
  CartItemModel({
    required this.producto,
    required this.cantidad,
    required this.total
  });

  ProductModel producto;
  int cantidad = 0;
  int total;
}
