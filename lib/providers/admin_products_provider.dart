import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/screens/screens.dart';

class AdminProductsProvider extends ChangeNotifier {
  late ProductModel product;
  List<File> imagesToUpload = [];

  //////// forms keys validator ////////
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //////// database references ////////
  final _databaseRef = FirebaseDatabase.instance.reference();
  final _storageRef = FirebaseStorage.instance.ref();

  //////// habilitar producto disponible ////////
  void updateAvailable(bool value) {
    product.available = value;
    notifyListeners();
  }

  //////// crear un producto ////////
  Future _createProduct() async {
    try {
      await _databaseRef.child("products/${product.id}").set(product.toMap());
    } catch (e) {
      print('Error al CREAR un producto $e');
    }
  }

  //////// editar un producto ////////
  Future _updateProduct(String id) async {
    try {
      await _databaseRef.child("products/${product.id}").update(product.toMap());
    } catch (e) {
      print('Error al EDITAR un producto $e');
    }
  }

  //////// borrar un producto ////////
  Future deleteProduct(String itemId) async {
    try {
      // borrar en firebase
      await _databaseRef.child("products/$itemId").remove();
      // borrar en storage: no se puede borrar el directorio directamente, hay que listar su contenido y borrar cada elemento que contiene
      await _storageRef.child("productsImages/$itemId").listAll().then((value) => value.items.forEach((element) => element.delete())).catchError((e) => print(e));
    } catch (e) {
      print('Error al BORRAR un producto $e');
    }
  }

  //////// borrar una sola imagen ////////
  Future deleteAnImageStorage({required int index}) async {
    try {
      //1- borrar imagen en storage, 2- borrar imagen en producto local, 3- actulizar lista de imagenes en firebase
      await FirebaseStorage.instance.refFromURL(product.images[index]).delete();
      product.images.removeAt(index);
      await _databaseRef.child("products/${product.id}").update({'images': product.images});
    } catch (e) {
      print('Error al BORRAR una imagen $e');
    }
    notifyListeners();
  }

  
  //////// subir imagenes a storage ////////
  double progress = 0;
  Future uploadImages(itemId) async {

    if (itemId == '') {
      itemId = product.id;
    }

    try {
      for (var item in imagesToUpload) {
        // obtener nombre de imagen para subir
        String fileName = basename(item.path);
        // subir imagen
        final uploadTask = await _storageRef.child('productsImages/$itemId/$fileName').putFile(item);
        // obtener url de la imagen subida y agregar a la lista de imgs
        uploadTask.ref.getDownloadURL().then((value) => product.images.add(value));

        progress += uploadTask.totalBytes * uploadTask.bytesTransferred / 100;
        
        notifyListeners();
      }
      print('PROGRES::: $progress');
      imagesToUpload.clear();
    } catch (e) {
      print('error en subir imagenes: $e');
    }
  }

  //////// crear producto en el servidor////////
  //** no cambiar el orden de las instrucciones **//
  Future createUpdateProduct({required BuildContext context, required String itemId}) async {
    if (itemId == "") {
      // create new product
      product.id = _databaseRef.push().key;
      try {
        await uploadImages(itemId);
        validateForm();
        await _createProduct().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AllProducts()), (route) => false));
      } catch (e) {
        print('error al crear producto $e');
      }
    } else {
      // update product
      try {
        await uploadImages(itemId);
        validateForm();
        await _updateProduct(itemId).then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AllProducts()), (route) => false));
      } catch (e) {
        print('Error al editar producto $e');
      }
    }
  }
}
