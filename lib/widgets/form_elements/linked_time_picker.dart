import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/form_elements/hinoki_time_picker.dart';
import 'linked_block.dart';
import 'hinoki_switch.dart';
import './../styles/textstyles.dart' as textstyles;
import 'hinoki_date_picker.dart';

class LinkedTimePicker extends StatefulWidget {
  final String position;
  final String labelText;
  final String defaultTime;

  LinkedTimePicker(
      {required this.position,
      required this.labelText,
      required this.defaultTime});

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
            Container(child: HinokiTimePicker(defaultTime: widget.defaultTime))
          ],
        ));
  }
}
