import 'package:flutter/material.dart';
import 'index.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return NavBarFrame(bodyWidget: Container(child: Text('Home View')));
  }
}
