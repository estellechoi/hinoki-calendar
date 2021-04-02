import 'package:flutter/material.dart';
import '../styles/colors.dart' as colors;

// Border Styles
final Border none = Border.fromBorderSide(BorderSide.none);

final Border lightgrey =
    Border.all(width: 1.0, style: BorderStyle.solid, color: colors.lightgrey);

final Border primaryDeco =
    Border.all(width: 1.0, style: BorderStyle.solid, color: colors.primaryDeco);

// Radius
final BorderRadius radiusBase = BorderRadius.all(Radius.circular(12.0));
final BorderRadius radiusRound = BorderRadius.circular(20.0);
