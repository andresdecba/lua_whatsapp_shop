import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/screens/screens.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class EditProduct2 extends StatelessWidget {
  // const EditProduct({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              _Formularios(),
              SizedBox(height: 12),
              PickImages(),
            ],
          ),
        ),
      ),
    ));
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
              //initialValue: '',
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Titulo'),
              onFieldSubmitted: (value) => _provider.title = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un titulo' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              //initialValue: '',
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Subtítulo'),
              onFieldSubmitted: (value) => _provider.subtitle = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese un subtítulo' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              //initialValue: '',
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: kInputDecoration(titulo: 'Descripción'),
              maxLines: 10,
              onFieldSubmitted: (value) => _provider.description = value,
              validator: (value) {
                return (value!.isEmpty) ? 'ingrese una descripción' : null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              //initialValue: '',
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              decoration: kInputDecoration(titulo: 'Precio'),
              onFieldSubmitted: (value) => _provider.price = int.parse(value),
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
            ElevatedButton(
              onPressed: () async {
                //_provider.createProductOnDB(context);
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 60)),
              child: Text('SUBIR PRODUCTO'),
            ),
          ],
        ));
  }
}
