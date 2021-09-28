import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _cartProvider = Provider.of<CartProvider>(context);
    final _products = Repositories().getProducts;

    return SafeArea(
      
      child: Scaffold(

          // appbar
          appBar: AppBar(
            title: Text('Carrito'),
            elevation: 0,
          ),

          // body
          body: _cartProvider.cartItemsLenght() == 0
          ? Center(child: Text('Tu carrito está vacío :('))
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

          // pie de pantalla: ver total y enviar pedido
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            alignment: Alignment.centerRight,
            height: 80,
            width: double.infinity,
            color: kColorGris,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: \$ ${_cartProvider.totalAPagar()}',
                      style: kTextTitleCard,
                    ),
                    //Divider(),
                    Text(
                      'Productos: ${_cartProvider.cartTotalItemsLenght()}',
                      style: kTextSubtitleCard,
                    ),
                  ],
                ),
                FloatingButton(
                  widget: Text('Hacer pedido', style: kTextMedium.copyWith(color: kWithe)),
                  onTap: () => Navigator.pushNamed(context, '/checkOutScreen') ,
                )
              ],
            ),
          ),
        ),
    );
  }
}