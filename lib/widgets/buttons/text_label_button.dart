import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;

class TextLabelButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final bool disabled;

  TextLabelButton({
    Key? key,
    required this.onPressed,
    this.label = '',
    this.disabled = false,
  }) : super(key: key);

  @override
  _TextLabelButtonState createState() => _TextLabelButtonState();
}

class _TextLabelButtonState extends State<TextLabelButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        child: Text(widget.label,
            style: TextStyle(
                color: colors.black,
                fontSize: fonts.sizeBase,
                fontWeight: fonts.weightBase,
                fontFamily: fonts.primary,
                fontFamilyFallback: fonts.primaryFallbacks)),
        style: ElevatedButton.styleFrom(
          primary: colors.transparent,
          onPrimary: colors.white,
          onSurface: colors.disabled,
          elevation: 0,
          // minimumSize: Size(_minWidth, 0.0),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
          shape: RoundedRectangleBorder(borderRadius: borders.radiusCircle),
          // textStyle: TextStyle(
          //     color: colors.black,
          //     fontSize: fonts.sizeBase,
          //     fontWeight: fonts.weightBase,
          //     fontFamily: fonts.primary,
          //     fontFamilyFallback: fonts.primaryFallbacks)
        ));
  }
}
