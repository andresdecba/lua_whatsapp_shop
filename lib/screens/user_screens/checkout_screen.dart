import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/get_products_provider.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _dataProvider = Provider.of<GetProductsProvider>(context);

    return SafeArea(
        child: Scaffold(

      appBar: AppBar(
        elevation: 0,
      ),

      body: Center(
        child: Text(_dataProvider.enviarTextoWhatsapp()),
      ),
    ));
  }
}
