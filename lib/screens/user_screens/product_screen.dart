import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //// recibir argumentos
    final _dataProvider = Provider.of<GetProductsProvider>(context);
    final int _index = ModalRoute.of(context)!.settings.arguments as int;
    final _product = _dataProvider.productsFromDB[_index];

    return SafeArea(
        child: Scaffold(          
            appBar: AppBar(
              elevation: 0,
            ),
            floatingActionButton: _AddCartButton(
              index: _index,
              dataProvider: _dataProvider,
            ),
            body: ListView(
              padding: EdgeInsets.only(top:20, bottom: 80 ),
              physics: ScrollPhysics(),
              children: [

                ////////// imagenes
                CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true,
                    disableCenter: true, enlargeCenterPage: true
                  ),
                  items: _product.images.map((image) {
                    return FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/placeHolder.jpg'),
                      image: NetworkImage(image),
                    );
                  }).toList(),
                ),

                ///////// descripcion
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _product.title,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Divider(
                          height: 20,
                        ),
                        Text(
                          _product.subtitle,
                          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        Divider(
                          height: 20,
                        ),
                        Text(
                          '\$ ${_product.price}',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Divider(
                          height: 20,
                        ),
                        Text(
                          _product.description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

class _AddCartButton extends StatelessWidget {
  const _AddCartButton({
    required this.index,
    required this.dataProvider,
    Key? key,
  }) : super(key: key);

  final int index;
  final GetProductsProvider dataProvider;

  @override
  Widget build(BuildContext context) {

    return Container(
        width: 220,
        padding: kPaddingSmall,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.blueAccent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Substract order quantity
            IconButton(onPressed: () => dataProvider.substractCartItem(index), icon: Icon(Icons.remove_circle)),

            // Quantity item order
            Text(
              dataProvider.productsFromDB[index].cartOrder.toString(),
              style: kTextMedium,
            ),

            // Add order quantity
            IconButton(onPressed: () => dataProvider.addCartItem(index), icon: Icon(Icons.add_circle)),

            SizedBox(
              width: 30,
            ),

            // Cart icon
            Text(
              dataProvider.cartItemsLenght().toString(),
              style: kTextMedium,
            ),
            IconButton(onPressed: () => Navigator.pushNamed(context, '/cartScreen'), icon: Icon(Icons.shopping_cart)),
          ],
        ));
  }
}
