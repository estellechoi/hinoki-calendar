import 'package:flutter/material.dart';
import './../widgets/layouts/layout.dart';

class UnknownView extends StatefulWidget {
  @override
  _UnknownViewState createState() => _UnknownViewState();
}

class _UnknownViewState extends State<UnknownView> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        child:
            Container(alignment: Alignment.center, child: Text('Unknown !')));
  }
}
