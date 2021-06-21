import 'package:flutter/material.dart';
import './../widgets/layouts/layout.dart';
import './../widgets/spinners/hinoki_spinner.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  @override
  Widget build(BuildContext context) {
    return Layout(child: HinokiSpinner());
  }
}
