import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:wappshop_2/screens/screens.dart';

class AdminProductsProvider extends ChangeNotifier {
  // propiedades
  String? description;
  int? price;
  String? subtitle;
  String? title;
  List<String> images = [];
  String? id; // el id se genera en sendAllToDB();
  bool available = false;
  bool onCart = false;
  int cartOrder = 0;

  List<File> imagesTmp = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  //////// database references ////////
  final _databaseRef = FirebaseDatabase.instance.reference();
  final _storageRef = FirebaseStorage.instance.ref();

  //////// crear un producto ////////
  Future _createProduct() async {
    try {
      await _databaseRef
          .child("products/$id")
          .set({'description': description, 'price': price, 'subtitle': subtitle, 'title': title, 'images': images, 'id': id, 'available': available, 'onCart': onCart, 'cartOrder': cartOrder});
      images.clear();
    } catch (e) {
      print('Error cargando los datos $e');
    }
  }

  //////// editar un producto ////////
  Future _updateProduct(String id) async {
    try {
      await _databaseRef
          .child("products/$id")
          .update({'description': description, 'price': price, 'subtitle': subtitle, 'title': title, 'available': available, 'onCart': onCart, 'cartOrder': cartOrder});
    
      await _databaseRef
          .child("products/$id")
          .update({'images': images });

    } catch (e) {
      print('Error cargando los datos $e');
    }
  }

  //////// borrar un producto ////////
  Future deleteProduct(String itemId) async {
    try {
      // borrar en firebase
      await _databaseRef.child("products/$itemId").remove();
      // storage: no se puede borrar el directorio directamente, hay que listar su contenido y borrar cada elemento que contiene
      await _storageRef.child("productsImages/$itemId").listAll().then((value) => value.items.forEach((element) => element.delete())).catchError((e) => print(e));
    } catch (e) {
      print(e);
    }
  }

  //////// borrar una imagen en storage ////////
  Future deleteAnImageStorage(String imageUrl) async {
    final _imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
    try {
      await _imageRef.delete().then((value) => print('borrado'));
    } catch (e) {
      print(e);
    }
  }

  //////// borrar una imagen en firebase ////////
  Future deleteAnImageDB(String itemId, List<String> imagesList) async {
    try {
      await _databaseRef.child("products/$itemId").update({'images': imagesList});
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  //////// subir imagenes a storage ////////
  Future _uploadImages() async {
    try {
      for (var item in imagesTmp) {
        // obtener nombre de imagen para subir
        String fileName = basename(item.path);
        // subir imagen
        final uploadTask = await _storageRef.child('productsImages/$id/$fileName').putFile(item);
        // obtener url de la imagen subida y agregar a la lista de imgs
        final taskSnapshot = uploadTask;
        await taskSnapshot.ref.getDownloadURL().then((value) => images.add(value));
      }
      imagesTmp.clear();
    } catch (e) {
      print('error en subir imagenes: $e');
    }
  }

  //////// agregar imagenes a un producto en storage ////////
  Future _addNewImagesToProduct(itemId) async {
    try {
      for (var item in imagesTmp) {
        // obtener nombre de imagen para subir
        String fileName = basename(item.path);
        // subir imagen
        final uploadTask = await _storageRef.child('productsImages/$itemId/$fileName').putFile(item);
        // obtener url de la imagen subida y agregar a la lista de imgs
        await uploadTask.ref.getDownloadURL().then((value) {
          images.add(value);
          print(' VALUEEEEE :::::::: $value  ');
        });
      }
      print('LISTA DE IMAGESSS ::::::::: $images');
      imagesTmp.clear();
    } catch (e) {
      print('error agregando imagenes en storage $e');
    }
  }

  //////// crear producto en el servidor////////
  //** no cambiar el orden de las instrucciones **//
  Future sendAllToDB({required BuildContext context, String? itemId}) async {

    if (itemId == null) {
      // create new product
      id = _databaseRef.push().key;
      try {
        await _uploadImages();
        validateForm();
        await _createProduct().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AllProducts()), (route) => false));
      } catch (e) {
        print('error al crear producto $e');
      }
    } else {
      // update product
      try {
        await _addNewImagesToProduct(itemId);
        await _updateProduct(itemId).then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const AllProducts()), (route) => false));
      } catch (e) {
        print('Error al editar producto $e');
      }
    }
  }
}
