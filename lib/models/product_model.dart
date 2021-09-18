// To parse this JSON data, do
// final product = productFromMap(jsonString);

import 'dart:convert';

ProductModel productModelFromMap(String str) => ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  ProductModel({
    required this.available,
    required this.description,
    required this.id,
    required this.images,
    required this.price,
    required this.subtitle,
    required this.title,
    required this.onCart,
    required this.cartOrder
  });

  bool available;
  String description;
  String id;
  List<String> images;
  int price;
  String subtitle;
  String title;
  bool onCart = false;
  int cartOrder = 0;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        available: json["available"],
        description: json["description"],
        id: json["id"],
        images:json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
        price: json["price"],
        subtitle: json["subtitle"],
        title: json["title"],
        onCart: json["onCart"],
        cartOrder: json["cartOrder"],
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "description": description,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "price": price,
        "subtitle": subtitle,
        "title": title,
        "onCart": onCart,
        "cartOrder": cartOrder,
      };
}
