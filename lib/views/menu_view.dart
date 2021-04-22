import 'package:flutter/material.dart';
import 'index.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return NavBarFrame(bodyWidget: Container());
  }
}
