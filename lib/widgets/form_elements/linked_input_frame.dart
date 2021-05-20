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
  final String defaultValue;
  final onChanged;
  final Widget child;

  LinkedInputFrame(
      {Key? key,
      this.type = 'text',
      required this.position,
      this.labelText = '',
      required this.defaultValue,
      required this.onChanged,
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
  bool _isFocused = false;

  handleFocus() {
    debugPrint('Focus : ${focusNode.hasFocus.toString()}');
    setState(() {
      _isFocused = focusNode.hasFocus;
    });
  }

  handleChange() {
    widget.onChanged(controller.text);
  }

  // Widget Life Cycle Related From Here ...
  @override
  void initState() {
    super.initState();
    focusNode.addListener(handleFocus);
    controller.addListener(handleChange);
    controller.text = widget.defaultValue;

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
  void dispose() {
    controller.dispose();
    super.dispose();
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
