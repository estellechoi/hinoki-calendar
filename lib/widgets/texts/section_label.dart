import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;

class SectionLabel extends StatelessWidget {
  final String text;

  SectionLabel({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: fonts.sizeCardSliderTitle,
          fontWeight: fonts.weightIntroCardTitle,
          height: fonts.lineHeightSub,
          color: colors.sectionLabel),
    );
  }
}
