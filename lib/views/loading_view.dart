import 'package:flutter/material.dart';
import './../widgets/layouts/layout.dart';
import './../widgets/spinners/hinoki_spinner.dart';
import './../widgets/styles/colors.dart' as colors;

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Layout(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: colors.white),
        )),
        HinokiSpinner()
      ],
    );
  }
}
