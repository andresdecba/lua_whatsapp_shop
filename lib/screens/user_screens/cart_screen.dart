import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/styles/text_styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<GetProductsProvider>(context);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Carrito'),
            elevation: 0,
          ),
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
                  'Total: ${_dataProvider.totalAPagar()}',
                  style: kTextBig,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/checkOutScreen'),
                    child: Text(
                      'Hacer pedido',
                      style: kTextMedium,
                    ))
              ],
            ),
          ),
          body: _dataProvider.cartItemsLenght() == 0
              ? Center(child: Text('no hay nada en el carro :('))
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: _dataProvider.productsFromDB.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (_dataProvider.productsFromDB[index].onCart == true) {
                            return CartCard(index: index);
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                )),
    );
  }
}
