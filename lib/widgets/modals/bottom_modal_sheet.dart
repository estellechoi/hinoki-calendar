import 'package:flutter/material.dart';
import '../styles/paddings.dart' as paddings;

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
            padding: EdgeInsets.symmetric(
                vertical: paddings.verticallModal,
                horizontal: paddings.horizontalModal),
            child: widget.child));
  }
}
