import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/screens/screens.dart';
import 'package:wappshop_2/styles/styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<AuthProvider>(context);
    final _repository = Repositories();

    return Container(
      color: kLightGrey,
      width: 250,
      padding: kPaddingBig,
      child: Column(
        children: [
          _Item(
            texto: 'home',
            icon: Icon(Icons.home, color: kColorGrisAzulado),
            link: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false),
          ),
          _Item(
            texto: 'Carrito',
            icon: Icon(
              Icons.shopping_cart,
              color: kColorGrisAzulado,
            ),
            link: () => Navigator.popAndPushNamed(context, '/cartScreen'),
          ),
          _Item(
            texto: 'Nosotros',
            icon: Icon(Icons.info, color: kColorGrisAzulado),
            link: () => Navigator.popAndPushNamed(context, '/aboutScreen'),
          ),
          Divider(),
          Spacer(),

          // entrar al admin
          GestureDetector(
            onTap: () => _provider.isSignedIn == false ? Navigator.popAndPushNamed(context, '/authScreen') : Navigator.popAndPushNamed(context, '/allProducts'),
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 75,
              child: Opacity(
                opacity: 0.3,
                child: FadeInImage(
                  placeholder: AssetImage('assets/placeHolder.jpg'),
                  image: CachedNetworkImageProvider(_repository.configModel.logoImage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key? key, required this.texto, required this.link, required this.icon}) : super(key: key);

  final String texto;
  final VoidCallback link;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        GestureDetector(
          onTap: link,
          child: Container(
            alignment: Alignment.centerLeft,
            width: 300,
            height: 50,
            child: Row(
              children: [
                icon,
                SizedBox(width: 25),
                Text(texto, style: kTextTitleCard),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
