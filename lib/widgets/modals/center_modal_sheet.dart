import 'package:flutter/material.dart';
import './../styles/colors.dart' as colors;
import './../styles/borders.dart' as borders;

class CenterModalSheet extends StatefulWidget {
  final Widget child;

  CenterModalSheet({required this.child});

  @override
  _CenterModalSheetState createState() => _CenterModalSheetState();
}

class _CenterModalSheetState extends State<CenterModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      decoration:
          BoxDecoration(color: colors.white, borderRadius: borders.radiusRound),
      child: widget.child,
    ));
  }
}
