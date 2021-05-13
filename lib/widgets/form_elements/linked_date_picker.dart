import 'package:flutter/material.dart';
import 'linked_block.dart';
import './../styles/textstyles.dart' as textstyles;
import 'hinoki_date_picker.dart';

class LinkedDatePicker extends StatefulWidget {
  final String position;
  final String label;
  final String defaultDate;
  final ValueChanged<String> onDaySelected;

  LinkedDatePicker(
      {required this.position,
      required this.label,
      required this.defaultDate,
      required this.onDaySelected});

  @override
  _LinkedDatePickerState createState() => _LinkedDatePickerState();
}

class _LinkedDatePickerState extends State<LinkedDatePicker> {
  @override
  Widget build(BuildContext context) {
    return LinkedBlock(
        position: widget.position,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(child: Text(widget.label, style: textstyles.inputText)),
            Container(
                child: HinokiDatePicker(
                    defaultDate: widget.defaultDate,
                    onDaySelected: widget.onDaySelected))
          ],
        ));
  }
}
