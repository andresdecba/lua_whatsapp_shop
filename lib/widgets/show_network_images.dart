import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';

class ShowNetworkImages extends StatefulWidget {
  const ShowNetworkImages({Key? key, }) : super(key: key);
  //final ProductModel product;
  @override
  State<ShowNetworkImages> createState() => _ShowNetworkImagesState();
}

class _ShowNetworkImagesState extends State<ShowNetworkImages> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AdminProductsProvider>(context);

    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            crossAxisCount: 3,
          ),
          itemCount: _provider.product.images.length,
          itemBuilder: (BuildContext context, int index) {

            return GestureDetector(

              onTap: () async => await _provider.deleteAnImageStorage(index: index),

              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(                    
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage(
                      placeholder: AssetImage('assets/placeHolder.jpg'),
                      image: NetworkImage( _provider.product.images[index]),
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 30,
                    )
                  )
                ]
              ),
            );
          },
        )
      ],
    );
  }
}
