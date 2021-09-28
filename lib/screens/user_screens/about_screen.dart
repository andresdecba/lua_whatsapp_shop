import 'package:flutter/material.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/styles/styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _repository = Repositories().configModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de nosotros'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
        padding: kPaddingBig,
        child: Column(
          children: [

            SizedBox(height: 30),

            // logo image
            FadeInImage(
              height: 120,
              fit: BoxFit.contain,
              placeholder: AssetImage('assets/placeHolder.jpg'),
              image: NetworkImage(_repository.logoImage),
            ),
            SizedBox(height: 30),

            // description text
            Text(
              'Quienes somos:',
              style: kTextTitleCard,
            ),
            SizedBox(height: 20),
            Text(
              _repository.description,
              textAlign: TextAlign.center,
              ),
            Divider(height: 60, thickness: 2,),

            // contacto
            Text(
              'contacto:',
              style: kTextTitleCard,
            ),
            SizedBox(height: 20),
            Text(
              'Celular: ${_repository.number}\n\neMail: ${_repository.eMail}',
              textAlign: TextAlign.center,
            ),
            Divider(height: 60, thickness: 2,),

            //enviar whatsapp
            ElevatedButton(
              onPressed: (){},
              style: kButtonStyle,
              child: Text('consultar por WhatsApp')
            )

          ],
        ),
      )),
    );
  }
}
