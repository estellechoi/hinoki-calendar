import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;

class HinokiButton extends StatefulWidget {
  final String type;
  final String color;
  final VoidCallback onPressed;
  final String label;
  final bool disabled;
  final bool fullWidth;

  HinokiButton(
      {Key? key,
      this.type = 'filled',
      this.color = 'primary',
      required this.onPressed,
      this.label = '',
      this.disabled = false,
      this.fullWidth = false})
      : super(key: key);

  @override
  _HinokiButtonState createState() => _HinokiButtonState();
}

class _HinokiButtonState extends State<HinokiButton> {
  @override
  Widget build(BuildContext context) {
    bool isFilled = widget.type == 'filled';
    double minWidth = widget.fullWidth ? double.infinity : 0;

    Color _color = colors.primary;

    switch (widget.color) {
      case 'primary':
        _color = colors.primary;
        break;
      case 'white':
        _color = colors.white;
        break;
      case 'black':
        _color = colors.black;
        break;
    }

    return ElevatedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        child: Text(widget.label,
            style: TextStyle(
                color: widget.disabled
                    ? colors.disabled
                    : isFilled
                        ? colors.white
                        : _color,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: fonts.primary,
                fontFamilyFallback: fonts.primaryFallbacks)),
        style: ElevatedButton.styleFrom(
          primary: isFilled ? _color : colors.transparent,
          onPrimary: isFilled ? _color : colors.transparent,
          onSurface: isFilled ? _color : colors.transparent,
          elevation: 0,
          minimumSize: Size(minWidth, 0),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
          shape: RoundedRectangleBorder(
              side: BorderSide(width: isFilled ? 0 : 1, color: _color),
              borderRadius: borders.radiusLight),
        ));
  }
}
