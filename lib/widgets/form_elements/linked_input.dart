import 'package:flutter/material.dart';
import 'linked_input_frame.dart';

class LinkedInput extends StatefulWidget {
  final String type; // text, textarea
  final String position;
  final String labelText;
  final String defaultValue;
  final onChanged;

  LinkedInput({
    Key? key,
    this.type = 'text',
    required this.position,
    this.labelText = '',
    required this.defaultValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LinkedInputState createState() => _LinkedInputState();
}

class _LinkedInputState extends State<LinkedInput> {
  @override
  Widget build(BuildContext context) {
    return LinkedInputFrame(
        position: widget.position,
        labelText: widget.labelText,
        defaultValue: widget.defaultValue,
        onChanged: widget.onChanged,
        child: Container());
  }
}
