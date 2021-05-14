import 'package:flutter/material.dart';
import 'package:flutter_app/types/color_palette_option.dart';
import './../styles/borders.dart' as borders;
import './../styles/colors.dart' as colors;

import './../../widgets/modals/center_modal_sheet.dart';
import './../../mixins/common.dart' as mixins;
import 'color_palette.dart';

class ColorPicker extends StatefulWidget {
  final Color color;
  final ValueChanged<ColorPaletteOption> onSelected;

  ColorPicker({required this.color, required this.onSelected});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final List<ColorPaletteOption> colorOptions = [
    ColorPaletteOption(id: 1, color: colors.black, label: 'Black'),
    ColorPaletteOption(id: 2, color: colors.primary, label: 'Primary'),
    ColorPaletteOption(id: 3, color: colors.disabled, label: 'Grey'),
    ColorPaletteOption(id: 4, color: colors.active, label: 'Active Blue'),
    ColorPaletteOption(
        id: 5, color: colors.fountainBlue, label: 'Fountain Blue'),
    ColorPaletteOption(id: 6, color: colors.blue, label: 'Blue'),
    ColorPaletteOption(id: 7, color: colors.countBadge, label: 'Notice Red'),
  ];

  Future _openColorPicker(BuildContext context) async {
    await mixins.openDialog(
        context: context,
        child: CenterModalSheet(
            child: IntrinsicWidth(
                child: IntrinsicHeight(
                    child: ColorPalette(
                        colorOptions: colorOptions,
                        onSelected: widget.onSelected)))));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _openColorPicker(context);
        },
        child: Container(
          width: 36,
          height: 30,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: borders.radiusBase),
        ));
  }
}
