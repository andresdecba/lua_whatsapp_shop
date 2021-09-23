import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wappshop_2/models/models.dart';

class ConfigProvider extends ChangeNotifier {
  
  // iniciar obteniendo del servidor
  ConfigProvider() {
    getConfigData();
  }

  // validar formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  // propiedades
  ConfigModel configData = ConfigModel(number: "", description: "");

  // database reference
  final _database = FirebaseDatabase.instance.reference();

  // streams
  late StreamSubscription<Event> _getConfigData;

  // recuperar datos from db
  Future getConfigData() async {
    try {
      _getConfigData = _database.child("config").onValue.listen((event) {
        final data = Map<String, dynamic>.from(event.snapshot.value);
        configData = ConfigModel.fromMap(data);
        notifyListeners();
      });
    } catch (e) {
      print('Error al recuperar datos de configuración $e');
    }
    return configData;
  }

  // guardar datos en db
  Future saveConfigData() async {
    try {
      _database.update(configData.toMap());
    } catch (e) {
      print('Error al guardar datos de configuración $e');
    }
  }

  @override
  void dispose() {
    _getConfigData.cancel();
    super.dispose();
  }
}
