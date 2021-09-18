import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/providers/providers.dart';

class ShowNetworkImages extends StatefulWidget {
  const ShowNetworkImages({Key? key, required this.product}) : super(key: key);
  final ProductModel product;
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
          itemCount: widget.product.images.length,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: GestureDetector(
                  onTap: () async {

                    // secuencia: 1-borrar imagen en storage, 2-borrar imagen en lista local, 3-borrar imagen en DB
                    await _provider.deleteAnImageStorage( widget.product.images[index],);
                    widget.product.images.removeAt(index);
                    await _provider.deleteAnImageDB(widget.product.id, widget.product.images);

                  },
                  child: Image.network(
                    widget.product.images[index],
                    fit: BoxFit.cover,
                  ),
                ));
          },
        )
      ],
    );
  }
}
