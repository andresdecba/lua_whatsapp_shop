import 'package:flutter/material.dart';

InputDecoration kInputDecoration({required String titulo}) {
  return InputDecoration(
      labelText: titulo,
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.black26)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: Colors.blueAccent)));
}

final kButtonStyle = ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40));
