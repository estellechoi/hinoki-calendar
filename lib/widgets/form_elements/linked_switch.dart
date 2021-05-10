import 'package:flutter/material.dart';
import 'linked_block.dart';
import 'hinoki_switch.dart';
import './../styles/textstyles.dart' as textstyles;

class LinkedSwitch extends StatefulWidget {
  final String position;
  final String labelText;

  LinkedSwitch({required this.position, required this.labelText});

  @override
  _LinkedSwitchState createState() => _LinkedSwitchState();
}

class _LinkedSwitchState extends State<LinkedSwitch> {
  bool _isActive = false;

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
                    isActive: _isActive,
                    onToggle: (bool isActive) {
                      setState(() {
                        _isActive = isActive;
                      });
                    }))
          ],
        ));
  }
}
