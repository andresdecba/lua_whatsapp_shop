import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _products = Repositories().getProducts;

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
          padding: EdgeInsets.only(top: 20, bottom: 90),
          physics: ScrollPhysics(),
          children: [
            ////////// imagenes
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                disableCenter: true,
                enlargeCenterPage: true,
              ),
              items: _product.images.map((image) {
                return ClipRRect(
                  borderRadius: kBorderRadius,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/placeHolder.jpg'),
                    image: CachedNetworkImageProvider(image), //NetworkImage(image),
                  ),
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
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    //Divider(height: 20),
                    SizedBox(
                      height: 20,
                    ),

                    // subtitulo
                    Text(
                      _product.subtitle,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // precio
                        Text(
                          '\$ ${_product.price}',
                          style: TextStyle(fontSize: 25),
                        ),

                        // disponible
                        !_product.available
                          ? Text(
                            'No disponible',
                            style: TextStyle(fontSize: 14, color: Colors.orange),
                          )
                          : SizedBox(),
                      ],
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),

                    // description
                    Text(
                      _product.description,
                      style: TextStyle(fontSize: 14),
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

    return FloatingButton(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Substract order quantity
              IconButton(
                onPressed: () => _cartProvider.substractCartItem(index),
                icon: Icon(Icons.remove_circle),
                constraints: BoxConstraints(),
                padding: EdgeInsets.all(8),
              ),
              // Cantidad de items pedidos
              Text(
                _cartProvider.getProducts.getProducts[index].cartOrder.toString(),
                style: kTextMedium,
              ),
              // Add order quantity
              IconButton(
                onPressed: () => _cartProvider.addCartItem(index),
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(),
                icon: Icon(Icons.add_circle),
              ),
            ],
          ),
          SizedBox(width: 10),
          Icon(Icons.circle, size: 7, color: Colors.white.withOpacity(0.5)),
          SizedBox(width: 18),

          // cantidad pedida
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _cartProvider.cartItemsLenght().toString(),
                style: kTextMedium.copyWith(color: kWithe),
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/cartScreen'),
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(),
                icon: Icon(Icons.shopping_cart, color: kWithe),
              ),
            ],
          ),
        ],
      ),
    );
  }
}





/*

Container(
      width: 200,
      height: 60,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: kColorCeleste,
      ),
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Substract order quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => _cartProvider.substractCartItem(index),
                      icon: Icon(Icons.remove_circle),
                    ),
                    // Cantidad de items pedidos
                    Text(
                      _cartProvider.getProducts.getProducts[index].cartOrder.toString(),
                      style: kTextMedium,
                    ),

                    // Add order quantity
                    IconButton(onPressed: () => _cartProvider.addCartItem(index), icon: Icon(Icons.add_circle)),
                  ],
                ),

                // cantidad pedida
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _cartProvider.cartItemsLenght().toString(),
                      style: kTextMedium.copyWith(color: kWithe),
                    ),
                    IconButton(onPressed: () => Navigator.pushNamed(context, '/cartScreen'),
                      icon: Icon(Icons.shopping_cart, color: kWithe,),
                    ),
                  ],
                ),
                
              ],
            ),      
    );


*/