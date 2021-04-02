import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;

class HelperLabel extends StatelessWidget {
  final String text;

  HelperLabel({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: fonts.sizeHelper,
            height: fonts.lineHeightBase,
            color: colors.helperLabel));
  }
}
