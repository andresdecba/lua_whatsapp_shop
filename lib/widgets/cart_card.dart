import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/styles/styles.dart';

class CartCard extends StatelessWidget {

  const CartCard({ Key? key,  required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {

    final _providerCart = Provider.of<CartProvider>(context);
    final _product = Repositories().getProducts[index];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 1),
      padding: kPaddingMedium,
      
      height: 140,
      decoration: BoxDecoration(
        color: kLightGrey,
        //borderRadius: kBorderRadius,
      ),
      child: Row(
        children: [
          // image
          AspectRatio(
            aspectRatio: 3/4,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/productScreen', arguments: index),
              child: ClipRRect(
                borderRadius: kBorderRadius,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/placeHolder.jpg'),
                  image: CachedNetworkImageProvider(_product.images.first), //NetworkImage(_product.images[0]),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),

          // info (expanded para que funcione el textOverflow)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // titulo
                Text(
                  _product.title,
                  style: kTextTitleCard,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(color: kColorGris,),
                Text(
                  'Precio: \$ ${_product.price} / Total: \$ ${_product.price*_product.cartOrder}',
                  style: kTextSubtitleCard,
                ),
                Divider(color: kColorGris,),


                /////////// remove / add items
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // remove
                    IconButton(
                      onPressed: () => _providerCart.substractCartItem2(index),
                      padding: EdgeInsets.only(right: 15),
                      constraints: BoxConstraints(),
                      icon: Icon(
                        Icons.remove_circle,
                        color: kColorGrisAzulado,
                      ),
                    ),

                    // quantity
                    Text(
                      _product.cartOrder.toString(),
                      style: kTextMedium.copyWith(color: kColorGrisAzulado),
                    ),

                    // add
                    IconButton(
                      onPressed: () => _providerCart.addCartItem(index),
                      padding: EdgeInsets.only(left: 15),
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.add_circle, color: kColorGrisAzulado),
                    ),
                    Spacer(),

                    // delete item
                    IconButton(
                      onPressed: () => _providerCart.deleteCartItem(index),
                      padding: EdgeInsets.only(right: 15),
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.delete_forever, color: kColorGrisAzulado,),
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
