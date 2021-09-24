import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);
  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {

  @override
  Widget build(BuildContext context) {

    final _adminProvider = Provider.of<AdminProductsProvider>(context);
    final _products = ProductsSingleton().getProducts;

    return SafeArea(
    child: Scaffold(
      
        // drawer
        drawer: CustomDrawer(),

        // appbar
        appBar: AppBar(
          title: Text('Administrar productos'),
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/configScreen'),
              icon: Icon(Icons.settings),
            )
          ],
          elevation: 0,
        ),

        // boton Agregar nuevo producto
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _adminProvider.product = ProductModel(available: false, description: '', id: '', images: [], price: 0, subtitle: '', title: '', onCart: false, cartOrder: 0);
            Navigator.pushNamed(context, '/editProduct');
          },
          label: Text('Agregar Nuevo'),
        ),

        // body
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: ListView.builder(
            addAutomaticKeepAlives: true,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _adminProvider.product = _products[index].copy();
                  Navigator.pushNamed(context, '/editProduct');
                },
                child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(30),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      )
                    ),
                    confirmDismiss: (direction) => _promptUser(),
                    onDismissed: (DismissDirection startToEnd) {
                      setState(() {
                        _adminProvider.deleteProduct(_products[index].id);
                        _products.removeAt(index);
                      });
                    },
                    child: HorizontalCard(product: _products[index])),
              );
            },
          ),
        ),
      ),
    );
  }

  // confirmar borrar producto
  Future<bool> _promptUser() async {
    
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("¿Borrar producto?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Borrar"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text('Cancelar'),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false;
  }
}
