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

  String id;
  String title;
  String subtitle;
  String description;
  List<String> images;
  int price;
  bool available;

  bool onCart = false;
  int cartOrder = 0;

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    available: json["available"],
    cartOrder: json["cartOrder"],
    description: json["description"],
    id: json["id"],
    images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
    onCart: json["onCart"],
    price: json["price"],
    subtitle: json["subtitle"],
    title: json["title"],
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


  // con esta funcion hacemos una copia nueva del ProductModel vacia,
  // como una nueva instacia nueva sin refrencia a la instacia original
  ProductModel copy() => ProductModel(
    available: available,
    description: description,
    id: id,
    images: images,
    price: price,
    subtitle: subtitle,
    title: title,
    onCart: onCart,
    cartOrder: cartOrder);

  @override
  String toString() {
    return 'descripcion: $description, id: $id, images: $images, onCart: $onCart, price: $price, subtitle: $subtitle, title: $title';
  }
}