// To parse this JSON data, do
// final producto = productoFromMap(jsonString);

import 'dart:convert';

Producto productoFromMap(String str) => Producto.fromMap(json.decode(str));

String productoToMap(Producto data) => json.encode(data.toMap());

class Producto {
    Producto({
      required this.available,
      required this.cartOrder,
      required this.description,
      required this.id,
      required this.images,
      required this.onCart,
      required this.price,
      required this.subtitle,
      required this.title,
    });

    bool available;
    int cartOrder;
    String description;
    String id;
    List<String> images;
    bool onCart;
    int price;
    String subtitle;
    String title;

    factory Producto.fromMap(Map<String, dynamic> json) => Producto(
        available: json["available"],
        cartOrder: json["cartOrder"],
        description: json["description"],
        id: json["id"],
        images: List<String>.from(json["images"].map((x) => x)),
        onCart: json["onCart"],
        price: json["price"],
        subtitle: json["subtitle"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "cartOrder": cartOrder,
        "description": description,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "onCart": onCart,
        "price": price,
        "subtitle": subtitle,
        "title": title,
    };
}
