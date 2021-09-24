import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';
import 'package:wappshop_2/styles/styles.dart';

class ProductScreen extends StatelessWidget {

  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var _products = ProductsSingleton().getProducts;

    // recibir los datos del producto desde el Home Screen
    final int _index = ModalRoute.of(context)!.settings.arguments as int;
    final _product = _products[_index];

    return SafeArea(
      child: Scaffold(
        // appbar
        appBar: AppBar(
          title: Text('Detalle de producto'),
          elevation: 0,
        ),

        floatingActionButton: _AddCartButton(index: _index),

        // body
        body: ListView(
          padding: EdgeInsets.only(top: 20, bottom: 80),
          physics: ScrollPhysics(),
          children: [
            ////////// imagenes
            CarouselSlider(
              options: CarouselOptions(height: 400, autoPlay: true, disableCenter: true, enlargeCenterPage: true),
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
                    // titulo
                    Text(
                      _product.title,
                      style: TextStyle(fontSize: 30),
                    ),
                    Divider(height: 20),

                    // subtitulo
                    Text(
                      _product.subtitle,
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                    Divider(height: 20),

                    // precio
                    Text(
                      '\$ ${_product.price}',
                      style: TextStyle(fontSize: 30),
                    ),
                    Divider(height: 20),

                    // description
                    Text(
                      _product.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCartButton extends StatelessWidget {
  const _AddCartButton({required this.index, Key? key}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);

    return Container(
      width: 220,
      padding: kPaddingSmall,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.blueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Substract order quantity
          IconButton(onPressed: () => _cartProvider.substractCartItem(index), icon: Icon(Icons.remove_circle)),

          // Cantidad de items pedidos
          Text(
            _cartProvider.getProducts.getProducts[index].cartOrder.toString(),
            style: kTextMedium,
          ),

          // Add order quantity
          IconButton(onPressed: () => _cartProvider.addCartItem(index), icon: Icon(Icons.add_circle)),
          SizedBox(width: 30),

          // Cart icon
          Text(
            _cartProvider.cartItemsLenght().toString(),
            style: kTextMedium,
          ),
          IconButton(onPressed: () => Navigator.pushNamed(context, '/cartScreen'), icon: Icon(Icons.shopping_cart)),
        ],
      ),
    );
  }
}
