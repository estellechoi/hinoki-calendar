import 'package:flutter/material.dart';

Future openDialog(
    {required BuildContext context, required Widget child}) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return child;
      });
}
