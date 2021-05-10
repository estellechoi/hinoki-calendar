import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;
import '../styles/fonts.dart' as fonts;
import '../styles/borders.dart' as borders;

class IconLabelButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String label;
  final bool disabled;

  IconLabelButton({
    Key? key,
    required this.onPressed,
    required this.icon,
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
        child: widget.icon,
        style: ElevatedButton.styleFrom(
            primary: colors.white,
            onPrimary: colors.white,
            // onSurface: colors.disabled,
            elevation: 0,
            // minimumSize: Size(_minWidth, 0.0),
            padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(borderRadius: borders.radiusCircle),
            textStyle: TextStyle(
                color: colors.black,
                fontSize: fonts.sizeBase,
                fontWeight: fonts.weightBase,
                fontFamily: fonts.primary,
                fontFamilyFallback: fonts.primaryFallbacks)));
  }
}
