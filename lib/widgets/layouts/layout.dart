import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  final Widget child;

  Layout({required this.child});

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: GestureDetector(
            onTap: () {
              WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(child: widget.child)));
  }
}
