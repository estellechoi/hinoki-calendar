import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/form_elements/hinoki_time_picker.dart';
import 'linked_block.dart';
import './../styles/textstyles.dart' as textstyles;

class LinkedTimePicker extends StatefulWidget {
  final String position;
  final String labelText;
  final int hour;
  final int minute;
  final bool isPMSelected;
  final ValueChanged<List<int>> onTimeSelected;
  final ValueChanged<bool> onZoneToggle;

  LinkedTimePicker({
    required this.position,
    required this.labelText,
    required this.hour,
    required this.minute,
    this.isPMSelected = false,
    required this.onTimeSelected,
    required this.onZoneToggle,
  });

  @override
  _LinkedTimePickerState createState() => _LinkedTimePickerState();
}

class _LinkedTimePickerState extends State<LinkedTimePicker> {
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
            Container(
                child: HinokiTimePicker(
              defaultHour: widget.hour,
              defaultMinute: widget.minute,
              isPMSelected: widget.isPMSelected,
              onTimeSelected: widget.onTimeSelected,
              onZoneToggle: widget.onZoneToggle,
            ))
          ],
        ));
  }
}
