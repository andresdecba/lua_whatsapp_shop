import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Text(
              'Ingreso al administrador',
              style: kTextTitleCard,
            ),
            SizedBox(height: 20),

            // password textfield
            Form(
                key: _provider.key,
                child: TextFormField(
                  decoration: kInputDecoration(titulo: 'Password').copyWith(
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(_obscureText ? Icons.remove_red_eye_outlined : Icons.remove_red_eye) ,
                    )
                  ),
                  obscureText: _obscureText,
                  onChanged: (value) => _provider.password = value,
                  validator: (value) => value!.isEmpty ? "Ingrese password" : null,
                )),
            SizedBox(height: 20),

            // login button
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
