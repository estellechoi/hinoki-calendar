import 'package:flutter/material.dart';
import 'linked_input_frame.dart';
import 'color_picker.dart';
import 'package:flutter_app/types/color_palette_option.dart';

class LinkedColorInput extends StatefulWidget {
  final String type; // text, textarea
  final String position;
  final String labelText;
  final String defaultText;
  final String text;
  final Color color;

  final ValueChanged<String> onChanged;
  final ValueChanged<ColorPaletteOption> onColorChanged;

  LinkedColorInput(
      {Key? key,
      this.type = 'text',
      required this.position,
      this.labelText = '',
      required this.defaultText,
      this.text = '',
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
        defaultText: widget.defaultText,
        onChanged: widget.onChanged,
        child: ColorPicker(
          color: widget.color,
          onSelected: widget.onColorChanged,
        ));
  }
}
