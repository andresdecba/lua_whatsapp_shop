import 'package:flutter/material.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/styles/styles.dart';

class HorizontalCard extends StatelessWidget {
  const HorizontalCard({Key? key, required this.product}) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    print('imagenesss ${product.images.length} // ${product.images}');

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(color: kLightGrey, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/placeHolder.jpg'),
                  image: NetworkImage((product.images.isEmpty) ? 'https://via.placeholder.com/200' : product.images.first) //'https://via.placeholder.com/200'
                  )),
          SizedBox(
            width: 10,
          ),
          Expanded(
            // usamos expadnded pa que funcione el textOverflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.subtitle,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  '\$ ${product.price}',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
