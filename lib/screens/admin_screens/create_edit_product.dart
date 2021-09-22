import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class CreateEditProduct extends StatelessWidget {
  const CreateEditProduct({
    Key? key,
  }) : super(key: key);

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
              _Formularios(),
              SizedBox(height: 12),

              // display network images
              _provider.product.images.isNotEmpty ? ShowNetworkImages() : SizedBox(),
              SizedBox(height: 12),

              // display local images
              PickImages(product: _provider.product),
              SizedBox(height: 12),

              // subir/actualizar producto
              ElevatedButton(
                onPressed: () async {
                  _promptUser(context, _provider.progress);
                  await _provider.createUpdateProduct(context: context, itemId: _provider.product.id);
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 60)),
                child: Text(_provider.product.id == '' ? 'SUBIR PRODUCTO' : 'ACTUALIZAR PRODUCTO'),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<bool> _promptUser(context, double progress) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(

            content: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: Colors.red,
              ),

            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("listo"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          ),
        ) ??
        false;
  }
}

class _Formularios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final _provider = Provider.of<AdminProductsProvider>(context);

    return Form(
        key: _provider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              initialValue: _provider.product.title,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Titulo'),
              onChanged: (value) => _provider.product.title = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un titulo' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              initialValue: _provider.product.subtitle,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Subtítulo'),
              onChanged: (value) => _provider.product.subtitle = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un subtítulo' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              initialValue: _provider.product.description,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Descripción'),
              maxLines: 10,
              onChanged: (value) => _provider.product.description = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese una descripción' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              initialValue: _provider.product.price == 0 ? '' : _provider.product.price.toString(),
              keyboardType: TextInputType.number,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: kInputDecoration(titulo: 'Precio'),
              onChanged: (value) => int.tryParse(value) == null ? _provider.product.price = 0 : _provider.product.price = int.parse(value),
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un precio' : null;
              },
            ),
            SizedBox(height: 12),
            SwitchListTile.adaptive(
              title: Text('Disponible'),
              value: _provider.product.available,
              onChanged: (value) => _provider.updateAvailable(value),
            ),
            SizedBox(height: 12),
          ],
        ));
  }
}
