import 'package:flutter/material.dart';
import 'colors.dart' as colors;
import 'fonts.dart' as fonts;

final TextStyle button = TextStyle(
    color: colors.white,
    fontSize: fonts.sizeBase,
    fontWeight: fonts.weightBase,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle inputText = TextStyle(
    color: colors.inputText,
    fontSize: fonts.sizeBase,
    height: fonts.lineHeightInput,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

// For Specific Places
final TextStyle navItem = TextStyle(
    fontSize: fonts.sizeNavItem,
    height: fonts.lineHeightNavItem,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle rangeHelperText = TextStyle(
    color: colors.primaryHigh,
    fontSize: fonts.sizeBase,
    height: fonts.lineHeightBase,
    fontWeight: fonts.weightBase,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle rangeHelperMaxText = TextStyle(
    color: colors.lightgrey,
    fontSize: fonts.sizeBase,
    height: fonts.lineHeightBase,
    fontWeight: fonts.weightBase,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);
