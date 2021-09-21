import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/get_products_provider.dart';
import 'package:wappshop_2/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        body: _List(),
      ),
    );
  }
}

// construir lista de productos
class _List extends StatelessWidget {
  const _List({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final _dataProvider = Provider.of<GetProductsProvider>(context);

    //if (_dataProvider.isLoading) return IsLoading();

    return CustomScrollView(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      slivers: [
        //appbar retraible
        _CustomAppBar(),

        //widgets y lista de noticias
        SliverList(
            delegate: SliverChildListDelegate([
          ListView.builder(
            addAutomaticKeepAlives: true,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: _dataProvider.productsFromDB.length,
            itemBuilder: (BuildContext context, int index) {
              
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/productScreen', arguments: index),
                child: HorizontalCard( product: _dataProvider.productsFromDB[index] ),
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
              child: Padding(padding: EdgeInsets.all(30), child: FadeInImage(placeholder: AssetImage('assets/placeHolder.jpg'), image: NetworkImage('https://via.placeholder.com/800x500'))),
            ),
          ],
        ),
      ),
    );
  }
}
