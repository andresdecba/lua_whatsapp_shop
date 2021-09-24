import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';
import 'package:wappshop_2/styles/styles.dart';

class CartCard extends StatelessWidget {

  const CartCard({ Key? key,  required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {

    final _providerCart = Provider.of<CartProvider>(context);
    final _product = ProductsSingleton().getProducts[index];

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(color: kLightGrey, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          // image
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/productScreen', arguments: index),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(fit: BoxFit.cover, height: 130, width: 130, placeholder: AssetImage('assets/placeHolder.jpg'), image: NetworkImage(_product.images[0]))),
          ),
          SizedBox(
            width: 10,
          ),

          // info (expanded para que funcione el textOverflow)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _product.title,
                  style: kTextMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Precio: \$ ${_product.price} / Total: \$ ${_product.price*_product.cartOrder}',
                  style: kTextSmall,
                ),
                Divider(color: kMediumGrey,),

                /////////// remove / add items
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // remove
                    IconButton(
                      onPressed: () => _providerCart.substractCartItem2(index),
                      icon: Icon(Icons.remove_circle),
                    ),

                    // quantity
                    Text(
                      _product.cartOrder.toString(),
                      style: kTextMedium,
                    ),

                    // add
                    IconButton(
                      onPressed: () => _providerCart.addCartItem(index),
                      icon: Icon(Icons.add_circle),
                    ),
                    Spacer(),

                    // delete item
                    IconButton(
                      onPressed: () => _providerCart.deleteCartItem(index),
                      icon: Icon(Icons.delete_forever),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
