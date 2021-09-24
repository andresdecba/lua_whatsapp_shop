import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  
  AuthProvider() {
    authState();
  }

  // propiedades
  FirebaseAuth authInstance = FirebaseAuth.instance;
  String password = "";
  bool isSignedIn = false;

  // validate form
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool validateForm() {
    return key.currentState?.validate() ?? false;
  }

  // SignIn
  Future signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "admin@whatsappshop2.com",
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // SignOut
  Future signOut() async {
    try {
      await authInstance.signOut();
    } catch (e) {
      print('Error al cerrar sesión $e');
    }
  }

  // userLoginState (==false navegar a pantalla auth, !=false navegar a pantalla admin)
  Future authState() async {
    try {
      authInstance.authStateChanges().listen((User? user) {
        if (user == null) {
          isSignedIn = false;
        } else {
          isSignedIn = true;
        }
      });
    } catch (e) {
      print('Error al cerrar sesión $e');
    }
    notifyListeners();
  }
}
