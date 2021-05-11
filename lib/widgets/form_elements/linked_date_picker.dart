import 'package:flutter/material.dart';
import 'linked_block.dart';
import 'hinoki_switch.dart';
import './../styles/textstyles.dart' as textstyles;
import 'hinoki_date_picker.dart';

class LinkedDatePicker extends StatefulWidget {
  final String position;
  final String labelText;
  final String defaultDate;

  LinkedDatePicker(
      {required this.position,
      required this.labelText,
      required this.defaultDate});

  @override
  _LinkedDatePickerState createState() => _LinkedDatePickerState();
}

class _LinkedDatePickerState extends State<LinkedDatePicker> {
  // bool _isActive = false;

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
            Container(child: HinokiDatePicker(defaultDate: widget.defaultDate))
          ],
        ));
  }
}
