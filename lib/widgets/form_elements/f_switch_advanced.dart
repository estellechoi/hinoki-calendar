import 'package:flutter/material.dart';
import '../texts/input_label.dart';
import 'f_switch.dart';
import '../styles/paddings.dart' as paddings;

class FSwitchAdvanced extends StatefulWidget {
  final String label;
  final String inactiveText;
  final String activeText;
  final bool isActive;
  final ValueChanged<bool> onToggle;

  FSwitchAdvanced(
      {Key? key,
      required this.label,
      required this.inactiveText,
      required this.activeText,
      required this.isActive,
      required this.onToggle})
      : super(key: key);

  @override
  _FSwitchAdvancedState createState() => _FSwitchAdvancedState();
}

class _FSwitchAdvancedState extends State<FSwitchAdvanced> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: InputLabel(text: widget.label, type: 'sub')),
        Expanded(
            child: Row(
          children: <Widget>[
            InputLabel(text: widget.inactiveText, type: 'sub'),
            Container(
                padding: EdgeInsets.symmetric(horizontal: paddings.gap),
                child: FSwitch(
                  isActive: widget.isActive,
                  onToggle: widget.onToggle,
                )),
            InputLabel(text: widget.activeText, type: 'sub'),
          ],
        )),
      ],
    );
  }
}
