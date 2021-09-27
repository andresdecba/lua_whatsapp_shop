import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ConfigProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);

    //final String number = _provider.configData.number;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Configuración'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: kPaddingMedium,
          child: Column(
            children: [

              // Formularios
              Form(
                key: _provider.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: kInputDecoration(titulo: 'Nro. de whatsApp'),
                      keyboardType: TextInputType.number,
                      initialValue: _provider.configData.number,
                      onChanged: (data) => _provider.configData.number = data,
                      validator: (value) => value!.isEmpty ? 'ingrese un numero válido' : null,
                    ),
                    SizedBox(height: 12),
                    Text('Formato: +54 351 6123458 (sin los espacios)', style: TextStyle(color: kColorGris, fontStyle: FontStyle.italic),),
                    SizedBox(height: 24),
                    TextFormField(
                      maxLines: 12,
                      decoration: kInputDecoration(titulo: 'Acerca de la empresa'),
                      keyboardType: TextInputType.text,
                      initialValue: _provider.configData.description,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (data) => _provider.configData.description = data,
                      validator: (value) => value!.isEmpty ? "Escriba una descripción" : null,
                    ),
                  ],
                )
              ),
              SizedBox(height: 12),

              // guardar formularios
              ElevatedButton(
                onPressed: () {
                  _provider.saveConfigData();
                  Navigator.pushNamed(context, '/allProducts');
                },
                style: kButtonStyle,
                child: Text('Guardar configuración')
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),


              // cerrar sesión
              ElevatedButton(
                onPressed: () async {
                  await _authProvider.signOut();
                  Navigator.pushNamed(context, '/');
                },
                style: kButtonStyle,
                child: Text('Cerrar sesión de administrador')
              ),
            ],
          ),
        ),
      ),
    );
  }
}
