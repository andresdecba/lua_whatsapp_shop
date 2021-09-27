import 'package:flutter/material.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/styles/styles.dart';

class ProductCard extends StatelessWidget {

  const ProductCard({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          padding: kPaddingMedium,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.symmetric(horizontal: BorderSide(color: Colors.black26, width: 0.3))
          ),
          child: Row(
            children: [

              // imagen
              ClipRRect(
                borderRadius: kBorderRadius,
                child: AspectRatio(
                  aspectRatio: 3/4,
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/placeHolder.jpg'),
                    image: NetworkImage(
                      product.images.isEmpty ? 'assets/placeHolder.jpg' : product.images.first                  
                    ) //'https://via.placeholder.com/200'
                    ),
                ),
                ),
              SizedBox(width: 15),

              // Texto con expanded para que funcione el textOverflow
              Expanded( 

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    // titulo
                    Text(
                      product.title,
                      style: kTextTitleCard,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),

                    // subtitulo
                    Text(
                      product.subtitle,
                      style: kTextSubtitleCard,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 10),
                    
                    Row(
                      children: [
                        // precio
                        Text(
                          '\$ ${product.price}',
                          style: kTextPriceCard,
                        ),
                        SizedBox(width: 12),

                        // disponible
                        !product.available
                          ? Text('No disponible', style: kTextExtaInfoCard.copyWith(color: Colors.orange),)
                          : SizedBox(),
                      ],
                    ),            
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(height: 0, color: kColorGris, indent: 16, endIndent: 16,),
      ],
    );
  }
}
