import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;

class IconLabelButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String label;
  final bool disabled;

  IconLabelButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
    this.label = '',
    this.disabled = false,
  }) : super(key: key);

  @override
  _IconLabelButtonState createState() => _IconLabelButtonState();
}

class _IconLabelButtonState extends State<IconLabelButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.disabled ? null : widget.onPressed,
        child: Icon(
          widget.iconData,
          color: widget.disabled ? colors.disabled : colors.black,
        ),
        style: ElevatedButton.styleFrom(
            primary: colors.white,
            onPrimary: colors.white,
            onSurface: colors.white,
            elevation: 0,
            // minimumSize: Size(_minWidth, 0.0),
            // padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(borderRadius: borders.radiusLight),
            textStyle: TextStyle(
                color: colors.black,
                fontSize: fonts.sizeBase,
                fontWeight: fonts.weightBase,
                fontFamily: fonts.primary,
                fontFamilyFallback: fonts.primaryFallbacks)));
  }
}
