import 'package:flutter/material.dart';
import 'package:wappshop_2/styles/decorators.dart';
import 'package:wappshop_2/styles/spacers.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
              Text('Ingreso al administrador', style: TextStyle(fontSize: 20),),
              SizedBox(height: 20),
              Form(
                child: TextFormField(
      
                  decoration: kInputDecoration(titulo: 'Password'),
      
                )
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){},
                child: Text('Ingresar'),
                style: kButtonStyle,
              )
            ],
          ),
        ),
      )
    );
  }
}
