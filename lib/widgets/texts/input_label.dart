import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;

class InputLabel extends StatelessWidget {
  final String text;
  final String type;

  InputLabel({Key? key, required this.text, this.type = 'default'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _fontSize = fonts.sizeBase;

    switch (type) {
      case 'default':
        _fontSize = fonts.sizeBase;
        break;
      case 'sub':
        _fontSize = fonts.sizeSub;
        break;
      default:
        _fontSize = fonts.sizeBase;
    }

    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: _fontSize,
            height: fonts.lineHeightBase,
            fontWeight: fonts.weightBase,
            color: colors.inputLabel));
  }
}
