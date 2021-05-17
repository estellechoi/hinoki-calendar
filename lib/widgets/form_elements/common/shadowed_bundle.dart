import 'package:flutter/material.dart';
import './../../../widgets/styles/shadows.dart' as shadows;

class ShadowedInputBundle extends StatefulWidget {
  final List<Widget> children;

  ShadowedInputBundle({this.children = const []});

  @override
  _ShadowedInputBundleState createState() => _ShadowedInputBundleState();
}

class _ShadowedInputBundleState extends State<ShadowedInputBundle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: shadows.input),
        child: Column(
          children: widget.children,
        ));
  }
}
