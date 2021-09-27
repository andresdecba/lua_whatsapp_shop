import 'package:flutter/material.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';

class CartProvider extends ChangeNotifier {
  // propiedades
  String usrName = '';
  String? usrMessage = '';
  final getProducts = ProductsSingleton();

  // forms keys validator
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  validateForm() {
    formKey.currentState?.validate() ?? false;
  }

  // agregar producto al carrito y sumar cantidad al item en PRODUCT SCREEN Y CART SCREEN
  void addCartItem(int index) {
    getProducts.getProducts[index].cartOrder++;

    if (getProducts.getProducts[index].cartOrder >= 1) {
      getProducts.getProducts[index].onCart = true;
    }
    notifyListeners();
  }

  // restar cantidad al item y quitar producto al carrito en PRODUCT SCREEN
  void substractCartItem(int index) {
    if (getProducts.getProducts[index].cartOrder >= 1) {
      getProducts.getProducts[index].cartOrder--;
    }

    if (getProducts.getProducts[index].cartOrder == 0) {
      getProducts.getProducts[index].onCart = false;
    }
    notifyListeners();
  }

  // restar cantidad al item en CART SCREEN
  substractCartItem2(int index) {
    if (getProducts.getProducts[index].cartOrder > 1) {
      getProducts.getProducts[index].cartOrder--;
    }
    notifyListeners();
  }

  // borrar item en CART SCREEN
  void deleteCartItem(int index) {
    print('indexx from provider $index');
    getProducts.getProducts[index].onCart = false;
    getProducts.getProducts[index].cartOrder = 0;
    notifyListeners();
  }

  // contar los items agregados al carrito
  int cartItemsLenght() {
    int contar = 0;
    for (var item in getProducts.getProducts) {
      if (item.onCart == true) {
        contar++;
      }
    }
    return contar;
  }

  // contar Todos los items agregados al carrito
  int cartTotalItemsLenght() {
    int contar = 0;
    for (var item in getProducts.getProducts) {
      if (item.onCart == true) {
        contar += item.cartOrder;
      }
    }
    return contar;
  }

  // calcular importe total a pagar
  int totalAPagar() {
    int total = 0;
    for (var item in getProducts.getProducts) {
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

    for (var item in getProducts.getProducts) {
      if (item.onCart == true) {
        resumenTxt += '-------------------\nProducto: ${item.title}\nCantidad: ${item.cartOrder}\nPrecio: \$${item.price} / Total: \$${item.price * item.cartOrder}\n';
      }
    }
    return userData += resumenTxt += totalpagar;
  }

  String showOrderDetails() {
    String userData = '-------------------\nDETALLE DE TU PEDIDO:\n';
    String resumenTxt = '';
    String totalpagar = '-------------------\nTotal a pagar: \$${totalAPagar().toString()}';

    for (var item in getProducts.getProducts) {
      if (item.onCart == true) {
        resumenTxt += '-------------------\nProducto: ${item.title}\nCantidad: ${item.cartOrder}\nPrecio: \$${item.price} / Total: \$${item.price * item.cartOrder}\n';
      }
    }
    return userData += resumenTxt += totalpagar;
  }
}
