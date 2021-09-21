import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/get_products_provider.dart';
import 'package:wappshop_2/styles/styles.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final _dataProvider = Provider.of<GetProductsProvider>(context);
    final _product = _dataProvider.productsFromDB[index];

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

          // info, usamos expanded para que funcione el textOverflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _dataProvider.productsFromDB[index].title,
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
                    IconButton(onPressed: () => _dataProvider.substractCartItem2(index), icon: Icon(Icons.remove_circle)),

                    // quantity
                    Text(
                      _dataProvider.productsFromDB[index].cartOrder.toString(),
                      style: kTextMedium,
                    ),

                    // add
                    IconButton(onPressed: () => _dataProvider.addCartItem(index), icon: Icon(Icons.add_circle)),
                    Spacer(),

                    // delete item
                    IconButton(
                        onPressed: () {
                          _dataProvider.deleteCartItem(index);
                        },
                        icon: Icon(Icons.delete_forever))
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
