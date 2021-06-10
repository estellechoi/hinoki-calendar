import 'package:flutter/material.dart';
import '../texts/input_label.dart';
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;
import '../styles/shadows.dart' as shadows;
import '../styles/borders.dart' as borders;
import '../styles/paddings.dart' as paddings;
import 'linked_block.dart';
import 'color_picker.dart';

class LinkedInputFrame extends StatefulWidget {
  final String type; // text, textarea
  final String position;
  final String labelText;
  final String? text;
  final String defaultText;
  final bool focused;
  final onChanged;
  final void Function(bool)? onFocused;
  final Widget child;

  LinkedInputFrame(
      {Key? key,
      this.type = 'text',
      required this.position,
      this.labelText = '',
      required this.defaultText,
      this.text,
      this.focused = false,
      required this.onChanged,
      this.onFocused,
      required this.child})
      : super(key: key);

  @override
  _LinkedInputFrameState createState() => _LinkedInputFrameState();
}

class _LinkedInputFrameState extends State<LinkedInputFrame> {
  // Q : Where to create these in Stateless widget ?
  final FocusNode focusNode = new FocusNode();
  final controller = TextEditingController();

  bool _obscureText = false;
  late final TextInputType _keyboardType;
  late final int? _maxLines;

  // States
  bool _focused = false;

  // Widget Life Cycle Related From Here ...
  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocus);
    controller.addListener(_handleChange);
    controller.text = widget.defaultText;
    _focused = widget.focused;

    switch (widget.type) {
      case 'text':
        _keyboardType = TextInputType.text;
        _maxLines = 1;
        break;
      case 'textarea':
        _keyboardType = TextInputType.multiline;
        _maxLines = 3;
        break;
      case 'password':
        _obscureText = true;
        _keyboardType = TextInputType.text;
        _maxLines = 1;
        break;
      default:
        _keyboardType = TextInputType.text;
        _maxLines = 1;
    }
  }

  @override
  void didUpdateWidget(covariant LinkedInputFrame oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text &&
        widget.text != null &&
        widget.text!.isEmpty) {
      controller.text = widget.text!;
    }

    if (oldWidget.focused != widget.focused) {
      setState(() {
        _focused = widget.focused;
        if (!_focused) focusNode.unfocus(disposition: UnfocusDisposition.scope);
      });
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  _handleFocus() {
    widget.onFocused!(focusNode.hasFocus);
  }

  _handleChange() {
    widget.onChanged(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return LinkedBlock(
        position: widget.position,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: TextFormField(
              obscureText: _obscureText,
              keyboardType: _keyboardType,
              maxLines: _maxLines,
              autofocus: false,
              focusNode: focusNode,
              controller: controller,
              cursorColor: colors.black,
              style: textstyles.inputText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: InputBorder.none,
                hintText: widget.labelText,
                hintStyle: textstyles.inputHintText,
              ),
            )),
            widget.child
          ],
        ));
  }
}
