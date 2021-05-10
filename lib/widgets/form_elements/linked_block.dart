import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;

class LinkedBlock extends StatefulWidget {
  final String position;
  final Widget child;

  LinkedBlock({required this.position, required this.child});

  @override
  _LinkedBlockState createState() => _LinkedBlockState();
}

class _LinkedBlockState extends State<LinkedBlock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _hasTopRadius =
        widget.position == 'top' || widget.position == 'single';
    final bool _hasBottomRadius =
        widget.position == 'bottom' || widget.position == 'single';
    final bool _hasDivider =
        widget.position == 'top' || widget.position == 'middle';

    return Container(
        padding: const EdgeInsets.only(top: 14, left: 15, right: 15, bottom: 0),
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_hasTopRadius ? 12 : 0),
            topRight: Radius.circular(_hasTopRadius ? 12 : 0),
            bottomLeft: Radius.circular(_hasBottomRadius ? 12 : 0),
            bottomRight: Radius.circular(_hasBottomRadius ? 12 : 0),
          ),
        ),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none,
                  bottom: _hasDivider
                      ? BorderSide(width: 0.5, color: colors.lightgrey)
                      : BorderSide.none),
            ),
            child: widget.child));
  }
}
