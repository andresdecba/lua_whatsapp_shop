import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/repositories.dart';
import 'package:wappshop_2/styles/colores.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: _BuilProductsList(),
      ),
    );
  }
}

// construir lista de productos
class _BuilProductsList extends StatelessWidget {
  const _BuilProductsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _products = Repositories().getProducts;
    final _provider = Provider.of<ProductsProvider>(context);

    return CustomScrollView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        //appbar sliver
        _CustomAppBar(),

        // listar productos
        SliverList(
            delegate: SliverChildListDelegate([
          ListView.builder(
            addAutomaticKeepAlives: true,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int index) {
              // navegar a la pantalla de producto
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productScreen', arguments: index),
                child: ProductCard(product: _products[index]),
              );
            },
          ),
        ]))
      ],
    );
  }
}

// cabecera, LOGO
class _CustomAppBar extends StatelessWidget {
  final _repository = Repositories();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 210,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: kColorPink,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kColorPink, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              //TODO: ver si se puede poner que tome el logo desde internet, aparentemente el delay es el problema
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  // child: CachedNetworkImage(
                  //   placeholder: (context, url) => Image.asset('assets/placeHolder.jpg'),
                  //   imageUrl: _repository.configModel.logoImage,
                  //   fit: BoxFit.contain,
                  // )
                  child: FadeInImage(
                    placeholder: AssetImage('assets/placeHolder.jpg'),
                    image: AssetImage('assets/lua-logo.png'),
                    //AssetImage('assets/lua-logo.png')
                    //NetworkImage(_repository.configModel.logoImage),
                    //CachedNetworkImageProvider(_repository.configModel.logoImage),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
