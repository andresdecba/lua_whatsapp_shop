import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';
import 'package:wappshop_2/widgets/widgets.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);
  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<CartProvider>(context);

    return SafeArea(
      child: Scaffold(

      // appbar
      appBar: AppBar(
        title: Text('Enviar pedido'),
        elevation: 0,
      ),

      // boton enviar 
      floatingActionButton: FloatingButton(
       widget: Text('Enviar !', style: kTextMedium.copyWith(color: kWithe)),
        onTap: () {
          if (_provider.formKey.currentState!.validate()) {

            // mostrar dialogo
            _promptUser(context);

            Future.delayed(const Duration(seconds: 1), () {
              // lanzar whatsapp
              launchWhatsApp(_provider.enviarTextoWhatsapp());
              // limpiar info de compra y navegar al home
              Future.delayed(const Duration(seconds: 1), () {
                for (var item in _provider.getProducts.getProducts) {
                  if (item.onCart == true) {
                    item.onCart = false;
                    item.cartOrder = 0;
                  }
                }
                _provider.usrName = '';
                _provider.usrMessage = '';
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              });
            });
          }
        },
        
      ),
      
      // body
      body: SingleChildScrollView(
        padding: kPaddingMedium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              alignment: Alignment.centerLeft,
              padding: kPaddingMedium,
              //height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kColorGris
              ),
              child: Text('Completa la información con tu nombre y un mensaje opcional. Al presionar "Enviar" se abrirá whatsapp para que puedas enviar tu pedido y proseguir con la venta por allí.  ' ),
            ),
            SizedBox(height: 12,),

            // Formularios: Nombre y mensaje
            Form(
              key: _provider.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _provider.usrName,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: kInputDecoration(titulo: 'Tu nombre'),
                    onChanged: (value) => _provider.usrName = value,
                    validator: (value) => (value!.isEmpty) ? 'ingresa tu nombre' : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    initialValue: _provider.usrMessage,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    maxLines: 10,
                    decoration: kInputDecoration(titulo: 'Mensaje (opcional)'),
                    onChanged: (value) => _provider.usrMessage = value,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text(
              _provider.showOrderDetails(),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 80,)
          ],
        ),
      ),
    ));
  }

  // lanzar a whatsapp
  launchWhatsApp(String text) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+0543516639258',
      text: text,
    );
    await launch('$link');
  }

  // mensaje de enviado exitosamente
  Future _promptUser(context) async {
    return await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: kPaddingBig,
        title: Column(
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 12,
            ),
            Text('Gracias por su compra :)'),
          ],
        ),
      ),
    );
  }
}
