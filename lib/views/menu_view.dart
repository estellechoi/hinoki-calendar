import 'package:flutter/material.dart';
import 'index.dart';
import 'package:flutter_app/widgets/buttons/text_label_button.dart';
import 'package:flutter_app/app_state.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './../utils/auth_provider.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  Future signoutFirebase(BuildContext context) async {
    await context.read<AuthProvider>().signout();
    appState.logout();
  }

  @override
  Widget build(BuildContext context) {
    return NavBarFrame(
        bodyWidget: Container(
            child: TextLabelButton(
      label: 'Sign out',
      onPressed: () {
        signoutFirebase(context);
      },
    )));
  }
}
