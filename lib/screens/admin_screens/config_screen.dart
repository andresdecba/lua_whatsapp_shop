import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/styles/styles.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ConfigProvider>(context);
    final _authProvider = Provider.of<AuthProvider>(context);
    final _repository = Repositories().configModel;

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

                    // phone number
                    TextFormField(
                      decoration: kInputDecoration(titulo: 'Nro. de whatsApp'),
                      keyboardType: TextInputType.number,
                      initialValue: _repository.number,
                      onChanged: (data) => _repository.number = data,
                      validator: (value) => value!.isEmpty ? 'ingrese un numero válido' : null,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Formato: +54 351 6123458 (sin los espacios)',
                      style: TextStyle(color: kColorGris, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 24),

                    // description text
                    TextFormField(
                      maxLines: 12,
                      decoration: kInputDecoration(titulo: 'Acerca de la empresa'),
                      keyboardType: TextInputType.text,
                      initialValue: _repository.description,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (data) => _repository.description = data,
                      validator: (value) => value!.isEmpty ? "Escriba una descripción" : null,
                    ),
                    SizedBox(height: 24),

                    // email
                    TextFormField(
                      decoration: kInputDecoration(titulo: 'eMail'),
                      keyboardType: TextInputType.emailAddress,
                      initialValue: _repository.eMail,
                      onChanged: (data) => _repository.eMail = data,
                      validator: (value) => value!.isEmpty ? 'Escriba su email' : null,
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              SizedBox(height: 12),

              // guardar formularios
              ElevatedButton(
                onPressed: () async {
                  await _provider.saveConfigData();
                  Navigator.pushNamedAndRemoveUntil(context, '/allProducts', (route) => false); //pushNamed(context, '/allProducts');
                },
                style: kButtonStyle,
                child: Text('Guardar configuración'),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),

              // cerrar sesión
              ElevatedButton(
                onPressed: () async {
                  await _authProvider.signOut();
                  Navigator.pushNamed(context, '/');
                },
                style: kButtonStyle,
                child: Text('Cerrar sesión de administrador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
