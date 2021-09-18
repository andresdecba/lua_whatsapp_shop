import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class CreateEditProduct extends StatelessWidget {
  const CreateEditProduct({Key? key, this.product}) : super(key: key);
  final ProductModel? product;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AdminProductsProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: kPaddingMedium,
          child: Column(
            children: [
              // forms
              _Formularios(
                product: product,
                provider: _provider,
              ),
              SizedBox(height: 12),

              // display network and local images
              product != null ? ShowNetworkImages(product: product!) : SizedBox(),
              SizedBox(height: 12),
              PickImages(product: product),
              SizedBox(height: 12),

              // subir/actualizar producto
              ElevatedButton(
                onPressed: () async {
                  product != null ? _provider.images.addAll(product!.images) : true;
                  await _provider.sendAllToDB(context: context, itemId: product?.id);
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 60)),
                child: Text(product != null ? 'ACTUALIZAR PRODUCTO' : 'SUBIR PRODUCTO'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class _Formularios extends StatelessWidget {
  const _Formularios({Key? key, this.product, required this.provider}) : super(key: key);
  final ProductModel? product;
  final AdminProductsProvider provider;

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AdminProductsProvider>(context);

    return Form(
        key: _provider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              initialValue: product?.title,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Titulo'),
              onFieldSubmitted: (value) => provider.title = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un titulo' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              initialValue: product?.subtitle,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Subtítulo'),
              onFieldSubmitted: (value) => provider.subtitle = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un subtítulo' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              initialValue: product?.description,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Descripción'),
              maxLines: 10,
              onFieldSubmitted: (value) => provider.description = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese una descripción' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              initialValue: product?.price.toString(),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: kInputDecoration(titulo: 'Precio'),
              onFieldSubmitted: (value) => provider.price = int.parse(value),
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un precio' : null;
              },
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Disponible'),
                Switch(value: true, onChanged: (value) {}),
              ],
            ),
            SizedBox(height: 12),
          ],
        ));
  }
}
