import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/providers.dart';
import 'package:wappshop_2/styles/styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _provider = Provider.of<ConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de nosotros'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: kPaddingMedium,
        child: Column(
          children: [

            // logo image
            FadeInImage(
              fit: BoxFit.contain,
              placeholder: AssetImage('assets/placeHolder.jpg'),
              image: NetworkImage('https://via.placeholder.com/800x500'),
            ),
            SizedBox(height: 30),

            // description text
            Text(_provider.configData.description),
          ],
        ),
      )),
    );
  }
}
