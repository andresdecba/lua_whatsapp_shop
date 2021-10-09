import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wappshop_2/styles/colores.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(AppState());
}

class AppState extends StatelessWidget {
  
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    ////// provider initializer
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider(), lazy: false,),
        ChangeNotifierProvider(create: (_) => ConfigProvider(), lazy: false,),
        ChangeNotifierProvider(create: (_) => AdminProductsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],

      ///// firebase initializer
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

      theme: ThemeData(
        fontFamily: 'Roboto',

        appBarTheme: AppBarTheme(
          backgroundColor: kColorPink,
          elevation: 0,
          toolbarHeight: 50,
          titleTextStyle: TextStyle(fontSize: 16,),
        ),

        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          primary: kColorGrisAzulado,
        ),)
      ),
      debugShowCheckedModeBanner: false,
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
      
    );
  }
}
