import 'package:flutter/material.dart';
import '../styles/paddings.dart' as paddings;
import '../styles/colors.dart' as colors;
import '../styles/borders.dart' as borders;

class BottomModalSheet extends StatefulWidget {
  final Widget child;

  BottomModalSheet({
    required this.child,
  });

  @override
  _BottomModalSheetState createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: Container(
            padding: EdgeInsets.all(0
                // vertical: paddings.verticallModal,
                // horizontal: paddings.horizontalModal
                ),
            decoration: BoxDecoration(
                color: colors.white, borderRadius: borders.radiusBottomModal),
            child: widget.child));
  }
}
