import 'package:flutter/material.dart';
import 'linked_input_frame.dart';
import 'color_picker.dart';

class LinkedColorInput extends StatefulWidget {
  final String type; // text, textarea
  final String position;
  final String labelText;
  final String defaultValue;
  final Color color;

  final ValueChanged<String> onChanged;
  final ValueChanged<Color> onColorChanged;

  LinkedColorInput(
      {Key? key,
      this.type = 'text',
      required this.position,
      this.labelText = '',
      required this.defaultValue,
      required this.color,
      required this.onChanged,
      required this.onColorChanged})
      : super(key: key);

  @override
  _LinkedColorInputState createState() => _LinkedColorInputState();
}

class _LinkedColorInputState extends State<LinkedColorInput> {
  @override
  Widget build(BuildContext context) {
    return LinkedInputFrame(
        position: widget.position,
        labelText: widget.labelText,
        defaultValue: widget.defaultValue,
        onChanged: widget.onChanged,
        child: ColorPicker(
          color: widget.color,
          onChanged: widget.onColorChanged,
        ));
  }
}
