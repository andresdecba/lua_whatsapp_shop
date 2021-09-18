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

  // factory CartItemModel.fromMap(Map<String, dynamic> json) => CartItemModel(
  //   producto: json['producto'],
  //   cantidad: json['cantidad'],
  //   total: json['total'],
  // );
}
