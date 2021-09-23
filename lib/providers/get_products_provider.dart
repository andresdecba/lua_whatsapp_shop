import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wappshop_2/models/product_model.dart';

class GetProductsProvider extends ChangeNotifier {
  GetProductsProvider() {
    //getSingleProduct();
    getAllProducts();
  }

  // propiedades
  List<ProductModel> productsFromDB = [];
  ProductModel? singleProduct;
  bool isLoading = true;
  String usrName = '';
  String? usrMessage = '';

  // forms keys validator
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  validateForm() {
    formKey.currentState?.validate() ?? false;
  }

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
        productsFromDB = dbResponse.values.map((orderAsJson) {
          return ProductModel.fromMap(Map<String, dynamic>.from(orderAsJson));
        }).toList();
        notifyListeners();
      });
    } catch (e) {
      print('Error al ontener los datos en $e');
    }
    return productsFromDB;
  }

  // agregar producto al carrito y sumar cantidad al item en PRODUCT SCREEN Y CART SCREEN
  void addCartItem(int index) {
    productsFromDB[index].cartOrder++;

    if (productsFromDB[index].cartOrder >= 1) {
      productsFromDB[index].onCart = true;
    }
    notifyListeners();
  }

  // restar cantidad al item y quitar producto al carrito en PRODUCT SCREEN
  void substractCartItem(int index) {
    if (productsFromDB[index].cartOrder >= 1) {
      productsFromDB[index].cartOrder--;
    }

    if (productsFromDB[index].cartOrder == 0) {
      productsFromDB[index].onCart = false;
    }
    notifyListeners();
  }

  // restar cantidad al item en CART SCREEN
  substractCartItem2(int index) {
    if (productsFromDB[index].cartOrder > 1) {
      productsFromDB[index].cartOrder--;
    }
    notifyListeners();
  }

  // borrar item en CART SCREEN
  void deleteCartItem(int index) {
    print('indexx from provider $index');
    productsFromDB[index].onCart = false;
    productsFromDB[index].cartOrder = 0;
    notifyListeners();
  }

  // contar los items agregados al carrito
  int cartItemsLenght() {
    int contar = 0;
    for (var item in productsFromDB) {
      if (item.onCart == true) {
        contar++;
      }
    }
    return contar;
  }

  // calcular importe total a pagar
  int totalAPagar() {
    int total = 0;
    for (var item in productsFromDB) {
      if (item.onCart == true) {
        total += item.price * item.cartOrder;
      }
    }
    return total;
  }

  // hacer el resumen del texto para mandar por whatsaap
  String enviarTextoWhatsapp() {
    String userData = '-------------------\nNombre: $usrName\nMensaje: $usrMessage\n';
    String resumenTxt = '';
    String totalpagar = '-------------------\nTotal a pagar: \$${totalAPagar().toString()}';

    for (var item in productsFromDB) {
      if (item.onCart == true) {
        resumenTxt += '-------------------\nProducto: ${item.title}\nCantidad: ${item.cartOrder}\nPrecio: \$${item.price} / Total: \$${item.price * item.cartOrder}\n';
      }
    }
    return userData += resumenTxt += totalpagar;
  }

  // cerrar streams
  @override
  void dispose() {
    _getSingleProductStream.cancel();
    _getAllProductsStream.cancel();
    super.dispose();
  }
}
