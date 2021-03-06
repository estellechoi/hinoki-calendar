import 'package:flutter/material.dart';
import 'linked_block.dart';
import 'hinoki_switch.dart';
import './../styles/textstyles.dart' as textstyles;

class LinkedSwitch extends StatefulWidget {
  final String position;
  final String labelText;
  final bool isActive;
  final onToggle;

  LinkedSwitch(
      {required this.position,
      required this.labelText,
      required this.isActive,
      required this.onToggle});

  @override
  _LinkedSwitchState createState() => _LinkedSwitchState();
}

class _LinkedSwitchState extends State<LinkedSwitch> {
  @override
  Widget build(BuildContext context) {
    return LinkedBlock(
        position: widget.position,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(widget.labelText, style: textstyles.inputText)),
            Container(
                child: HinokiSwitch(
                    isActive: widget.isActive, onToggle: widget.onToggle))
          ],
        ));
  }
}
