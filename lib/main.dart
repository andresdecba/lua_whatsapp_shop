import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/providers/admin_products_provider.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    ////// provider initialize
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetProductsProvider()),
        ChangeNotifierProvider(create: (_) => AdminProductsProvider()),
        ChangeNotifierProvider(create: (_) => ConfigProvider(), lazy: false, ),

      ],

      ///// firebase initialize
      child: FutureBuilder(
        future: _fbApp,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Error de incializacion de firebase');
          } else if (snapshot.hasData) {
            return MyApp();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/productScreen': (_) => ProductScreen(),
        '/cartScreen': (_) => CartScreen(),
        '/checkOutScreen': (_) => CheckOutScreen(),
        '/allProducts': (_) => AllProducts(),
        '/editProduct': (_) => CreateEditProduct(),
        '/configScreen': (_) => ConfigScreen(),
        '/aboutScreen': (_) => AboutScreen(),
        '/authScreen': (_) => AuthScreen(),



      },
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Colors.purple,
      ),
    );
  }
}
