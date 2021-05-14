import 'package:flutter/material.dart';
import 'color_palette_item.dart';
import './../styles/borders.dart' as borders;
import './../../types/color_palette_option.dart';

class ColorPalette extends StatefulWidget {
  final List<ColorPaletteOption> colorOptions;
  final ValueChanged<ColorPaletteOption> onSelected;

  ColorPalette({this.colorOptions = const [], required this.onSelected});

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  List<ColorPaletteOption> _colorOptions = const [];

  @override
  void initState() {
    super.initState();
    _colorOptions = widget.colorOptions;
  }

  void _handleColorPick(ColorPaletteOption option) {
    widget.onSelected(option);

    setState(() {
      _colorOptions = _colorOptions.map((_option) {
        _option.setIsSelected = option.id == _option.id;
        return _option;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 40, bottom: 40, left: 32, right: 12),
        // decoration: BoxDecoration(borderRadius: borders.radiusBase),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (var _option in _colorOptions)
              GestureDetector(
                  onTap: () {
                    _handleColorPick(_option);
                  },
                  child: ColorPaletteItem(
                      color: _option.color, isSelected: _option.isSelected))
          ],
        ));
  }
}
