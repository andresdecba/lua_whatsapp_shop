import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/repositories/products_singleton.dart';
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
    final _products = ProductsSingleton().getProducts;
    final _productsProvider = Provider.of<ProductsProvider>(context);

    return CustomScrollView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        //appbar retraible
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
                  onTap: () => Navigator.pushNamed(context, '/productScreen', arguments: index), child: HorizontalCard(product: _products[index]) // _provider.products.getProducts[index] ),
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
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //backgroundColor: kWithe,
      actions: const [],
      expandedHeight: 210,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Column(
          children: const [
            SizedBox(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: FadeInImage(
                  placeholder: AssetImage('assets/placeHolder.jpg'),
                  image: NetworkImage('https://via.placeholder.com/800x500'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
