import 'package:flutter/material.dart';
import 'linked_input_frame.dart';

class LinkedInput extends StatefulWidget {
  final String type; // text, textarea
  final String position;
  final String labelText;
  final String defaultText;
  final String? text;
  final bool focused;
  final onChanged;
  final void Function(bool)? onFocused;

  LinkedInput(
      {Key? key,
      this.type = 'text',
      required this.position,
      this.labelText = '',
      required this.defaultText,
      this.text,
      this.focused = false,
      required this.onChanged,
      this.onFocused})
      : super(key: key);

  @override
  _LinkedInputState createState() => _LinkedInputState();
}

class _LinkedInputState extends State<LinkedInput> {
  @override
  Widget build(BuildContext context) {
    return LinkedInputFrame(
        position: widget.position,
        type: widget.type,
        labelText: widget.labelText,
        defaultText: widget.defaultText,
        text: widget.text,
        focused: widget.focused,
        onChanged: widget.onChanged,
        onFocused: widget.onFocused,
        child: Container());
  }
}
