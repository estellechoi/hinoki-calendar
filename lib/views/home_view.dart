import 'package:flutter/material.dart';
import 'index.dart';
import '../widgets/buttons/f_button.dart';
import '../app_state.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        bodyWidget: Container(
            child: Column(
      children: <Widget>[
        FButton(
            type: 'blue',
            onPressed: () {
              appState.logout();
            },
            text: '테스트')
      ],
    )));
  }
}
