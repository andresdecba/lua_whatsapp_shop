import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/models/models.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/screens/screens.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    final _providerGetData = Provider.of<GetProductsProvider>(context);
    final _providerAdmin = Provider.of<AdminProductsProvider>(context);

    return SafeArea(
        child: Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: Text('Administrar productos'),
              elevation: 0,
            ),
            floatingActionButton: FloatingActionButton.extended(

                onPressed: () {
                  _providerAdmin.product = ProductModel(available: false, description: '', id: '', images: [], price: 0, subtitle: '', title: '', onCart: false, cartOrder: 0);
                  Navigator.pushNamed(context, '/editProduct');
                  },

                label: Row(
                  children: const [
                    //Icon(Icons.add),
                    Text('Agregar Nuevo')
                  ],
                )),
            body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: ListView.builder(
                addAutomaticKeepAlives: true,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _providerGetData.productsFromDB.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _providerAdmin.product = _providerGetData.productsFromDB[index].copy();
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
                            _providerAdmin.deleteProduct(_providerGetData.productsFromDB[index].id);
                            _providerGetData.productsFromDB.removeAt(index);
                          });
                        },
                        child: HorizontalCard(product: _providerGetData.productsFromDB[index])),
                  );
                },
              ),
            )));
  }

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
