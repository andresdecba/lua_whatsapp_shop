import 'package:wappshop_2/models/models.dart';

////// singleton repositories /////
class Repositories {

  static final Repositories _singleton = Repositories._internal();

  factory Repositories() {
    return _singleton;
  }

  Repositories._internal();

  // propiedades
  List<ProductModel> getProducts = [];
  
  ConfigModel configModel = ConfigModel(number: "", description: "", logoImage: "", eMail: '');

}
