import 'package:flutter/material.dart';
import 'package:wappshop_2/styles/styles.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({this.onTap, required this.widget, Key? key}) : super(key: key);

  final VoidCallback? onTap;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: widget,
      backgroundColor: kColorCeleste,
      elevation: 0,
      extendedPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onPressed: onTap,
    );
  }
}
