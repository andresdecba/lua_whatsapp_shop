import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _cartProvider = Provider.of<CartProvider>(context);
    final _products = ProductsSingleton().getProducts;

    return SafeArea(
      
      child: Scaffold(

          // appbar
          appBar: AppBar(
            title: Text('Carrito'),
            elevation: 0,
          ),

          // pie de pantalla: ver total y gacer pedido
          bottomNavigationBar: Container(
            padding: kPaddingBig,
            alignment: Alignment.centerLeft,
            height: 100,
            width: double.infinity,
            color: kMediumGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$ ${_cartProvider.totalAPagar()}',
                  style: kTextBig,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/checkOutScreen'),
                  child: Text(
                    'Hacer pedido',
                    style: kTextMedium,
                  ),
                )
              ],
            ),
          ),

          // body
          body: _cartProvider.cartItemsLenght() == 0
          ? Center(child: Text('no hay nada en el carro :('))
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_products[index].onCart == true) {
                        return CartCard(index: index);
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
