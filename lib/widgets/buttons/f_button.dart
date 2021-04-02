import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/textstyles.dart' as textstyles;

class FButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool disabled;
  final bool fullWidth;

  FButton(
      {Key? key,
      required this.onPressed,
      this.text = '',
      this.disabled = false,
      this.fullWidth = false})
      : super(key: key);

  @override
  _FButtonState createState() => _FButtonState();
}

class _FButtonState extends State<FButton> {
  @override
  Widget build(BuildContext context) {
    double _minWidth = widget.fullWidth ? double.infinity : 112.0;

    return ElevatedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        child: Text(widget.text),
        style: ElevatedButton.styleFrom(
            primary: colors.primaryHigh,
            onPrimary: colors.white,
            // onSurface: colors.disabled,
            elevation: 0,
            minimumSize: Size(_minWidth, 0.0),
            padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            textStyle: textstyles.button));
  }
}
