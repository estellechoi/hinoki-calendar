import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;

class HinokiButton extends StatefulWidget {
  final String type;
  final VoidCallback onPressed;
  final String label;
  final bool disabled;
  final bool fullWidth;

  HinokiButton(
      {Key? key,
      this.type = 'filled',
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

    return ElevatedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        child: Text(widget.label,
            style: TextStyle(
                color: widget.disabled ? colors.disabled : colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: fonts.primary,
                fontFamilyFallback: fonts.primaryFallbacks)),
        style: ElevatedButton.styleFrom(
          primary: isFilled ? colors.coralFaded : colors.transparent,
          onPrimary: isFilled ? colors.coralFaded : colors.transparent,
          onSurface: isFilled ? colors.coralFaded : colors.transparent,
          elevation: 0,
          minimumSize: Size(minWidth, 0),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20.0),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: isFilled ? 0 : 1,
                  color: isFilled ? colors.coralFaded : colors.white),
              borderRadius: borders.radiusLight),
        ));
  }
}
