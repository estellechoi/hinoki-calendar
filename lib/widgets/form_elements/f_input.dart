import 'package:flutter/material.dart';
import '../texts/input_label.dart';
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;
import '../styles/shadows.dart' as shadows;
import '../styles/borders.dart' as borders;
import '../styles/paddings.dart' as paddings;

class FInput extends StatefulWidget {
  final String type; // text, textarea
  final String hintText;
  final String labelText;
  final String defaultValue;
  final onChanged;

  FInput({
    Key? key,
    this.type = 'text',
    required this.hintText,
    this.labelText = '',
    required this.defaultValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FInputState createState() => _FInputState();
}

class _FInputState extends State<FInput> {
  // Q : Where to create these in Stateless widget ?
  final FocusNode focusNode = new FocusNode();
  final controller = TextEditingController();

  late final TextInputType _keyboardType;
  late final int? _maxLines;

  // States
  bool isFocused = false;

  handleFocus() {
    debugPrint('Focus : ${focusNode.hasFocus.toString()}');
    setState(() {
      isFocused = focusNode.hasFocus;
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
    return Column(children: <Widget>[
      // Label
      Container(
          padding: EdgeInsets.only(bottom: paddings.formFieldLabel),
          child: Row(
            children: <Widget>[
              Expanded(child: InputLabel(text: widget.labelText)),
            ],
          )),
      // Input
      Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          decoration: BoxDecoration(
              color: isFocused ? colors.primaryFocused : colors.white,
              border: borders.lightgrey,
              borderRadius: borders.radiusBase,
              boxShadow: shadows.input),
          child: Row(children: <Widget>[
            Expanded(
                child: TextFormField(
              keyboardType: _keyboardType,
              maxLines: _maxLines,
              autofocus: false,
              focusNode: focusNode,
              controller: controller,
              style: textstyles.inputText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                isDense: true,
                border: InputBorder.none,
                hintText: widget.hintText,
              ),
            ))
          ]))
    ]);
  }
}
