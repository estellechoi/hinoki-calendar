import 'package:flutter/material.dart';
import 'colors.dart' as colors;
import 'fonts.dart' as fonts;

final TextStyle comment = TextStyle(
    color: colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle fadedComment = TextStyle(
    color: colors.disabled,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle strongComment = TextStyle(
    color: colors.primary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle helpText = TextStyle(
    color: colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle strongHelpText = TextStyle(
    color: colors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle button = TextStyle(
    color: colors.white,
    fontSize: fonts.sizeBase,
    fontWeight: FontWeight.w400,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle inputText = TextStyle(
    color: colors.inputText,
    fontSize: fonts.sizeBase,
    fontWeight: FontWeight.w400,
    height: fonts.lineHeightInput,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle inputHintText = TextStyle(
    color: colors.blackAlphaDeep,
    fontSize: fonts.sizeBase,
    fontWeight: FontWeight.w400,
    height: fonts.lineHeightInput,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle cardTitle = TextStyle(
    color: colors.cardTitle,
    fontSize: fonts.sizeCardTitle,
    fontWeight: fonts.weightBase,
    height: fonts.lineHeightBase,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle introCardTitle = TextStyle(
    color: colors.cardTitle,
    fontSize: fonts.sizeIntroCardTitle,
    fontWeight: fonts.weightIntroCardTitle,
    height: fonts.lineHeightIntroCardTitle,
    fontFamily: fonts.primary,
    fontFamilyFallback: fonts.primaryFallbacks);

final TextStyle introCardSummary = TextStyle(
    color: colors.cardTitle,
    fontSize: fonts.sizeIntroCardSummary,
    fontWeight: fonts.weightBase,
    height: fonts.lineHeightIntroCardSummary,
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

final TextStyle calendarTodayText = TextStyle(
  color: colors.black,
  fontSize: fonts.sizeBase,
  height: fonts.lineHeightBase,
  fontWeight: fonts.weightBase,
);

final TextStyle calendarEvent = TextStyle(
  color: colors.black,
  fontSize: fonts.sizeCalendarEvent,
  height: fonts.lineHeightBase,
);

final TextStyle calendarStrongCell = TextStyle(
  color: colors.black,
  fontSize: fonts.sizeBase,
  height: fonts.lineHeightBase,
);

final TextStyle calendarColored = TextStyle(
  color: colors.calendarColoredCell,
  fontSize: fonts.sizeBase,
  height: fonts.lineHeightBase,
);
