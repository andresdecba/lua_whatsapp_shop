import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wappshop_2/screens/screens.dart';
import 'package:wappshop_2/styles/styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Container(
      color: kLightGrey,
      width: 300,
      padding: kPaddingBig,
      child: Column(
        children: [

         GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 300,
              height: 50,
              child: Text(
                'Home',
                style: kTextMedium
              )
            ),
          ),
          Divider(),

          GestureDetector(
            onTap: () => Navigator.popAndPushNamed(context, '/cartScreen'),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 300,
              height: 50,
              child: Text(
                'Carrito',
                style: kTextMedium
              )
            ),
          ),
          Divider(),

          Spacer(),
          GestureDetector(
            onTap: () => Navigator.popAndPushNamed(context, '/allProducts'),
            child: Container(
              alignment: Alignment.centerLeft,
              width: 300,
              height: 50,
              child: Text(
                'Admin',
                style: kTextMedium
              )
            ),
          ),
        ],
      ),
    );
  }
}