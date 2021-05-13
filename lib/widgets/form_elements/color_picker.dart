import 'package:flutter/material.dart';
import './../styles/borders.dart' as borders;

class ColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onChanged;

  ColorPicker({required this.color, required this.onChanged});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  void _handleTap() {
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: 36,
          height: 30,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: borders.radiusBase),
        ));
  }
}
