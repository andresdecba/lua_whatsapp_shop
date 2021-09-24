import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AuthProvider>(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Administrador'),
        elevation: 0,
      ),
      body: Padding(
        padding: kPaddingMedium,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ingreso al administrador',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Form(
                key: _provider.key,
                child: TextFormField(
                  decoration: kInputDecoration(titulo: 'Password'),
                  obscureText: true,
                  onChanged: (value) => _provider.password = value,
                  validator: (value) => value!.isEmpty ? "Ingrese password" : null,
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async {
                await _provider.signIn();

                _provider.isSignedIn == true ? Navigator.pushNamed(context, '/allProducts') : SizedBox();

                //TODO: llamar aviso de clave incorrecta
              },
              child: Text('Ingresar'),
              style: kButtonStyle,
            )
          ],
        ),
      ),
    ));
  }
}
