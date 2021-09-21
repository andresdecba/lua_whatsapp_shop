import 'package:flutter/material.dart';


class IsLoading extends StatelessWidget {

  const IsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: CircularProgressIndicator(),
      ),
    );
  }
}