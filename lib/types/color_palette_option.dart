import 'package:flutter/material.dart';

class ColorPaletteOption {
  final int id;
  final Color color;
  final String label;
  bool isSelected;

  ColorPaletteOption({
    required this.id,
    required this.color,
    required this.label,
    this.isSelected = false,
  });

  bool get getIsSelected => isSelected;
  set setIsSelected(bool value) {
    isSelected = value;
  }
}
