import 'package:flutter/material.dart';
import './../styles/borders.dart' as borders;
import './../styles/shadows.dart' as shadows;

class ColorPaletteItem extends StatefulWidget {
  final Color color;
  final bool isSelected;

  ColorPaletteItem({required this.color, this.isSelected = false});

  @override
  _ColorPaletteItemState createState() => _ColorPaletteItemState();
}

class _ColorPaletteItemState extends State<ColorPaletteItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 30,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: borders.radiusBase,
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                      color: widget.color.withOpacity(0.8),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 2))
                ]
              : []),
    );
  }
}
