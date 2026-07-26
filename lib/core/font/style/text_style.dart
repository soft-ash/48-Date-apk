import 'package:flutter/material.dart';
import '../../constant/colors.dart';
import '../../utils/screen_utils.dart';

class AppTextStyle {
  static const String fontFamily = 'Manrope';

  /// Standard font weights based on your design
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  /// Internal base generator to keep code clean
  static TextStyle _baseStyle({
    required double fontSize,
    required double lineHeight,
    double letterSpacingPercent = 0,
    FontWeight fontWeight = regular,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      height: lineHeight / fontSize,
      letterSpacing: fontSize * (letterSpacingPercent / 100),
      fontWeight: fontWeight,
      color: AppColor.gray900,
    );
  }

  // ==========================================
  // Headings (h1 to h6) - For Titles & Big Texts
  // ==========================================

  static TextStyle h1({FontWeight weight = regular}) => _baseStyle(
    fontSize: 72,
    lineHeight: 90,
    letterSpacingPercent: -2,
    fontWeight: weight,
  );

  static TextStyle h2({FontWeight weight = regular}) => _baseStyle(
    fontSize: 60,
    lineHeight: 72,
    letterSpacingPercent: -2,
    fontWeight: weight,
  );

  static TextStyle h3({FontWeight weight = regular}) => _baseStyle(
    fontSize: 48,
    lineHeight: 60,
    letterSpacingPercent: -2,
    fontWeight: weight,
  );

  static TextStyle h4({FontWeight weight = regular}) => _baseStyle(
    fontSize: 36,
    lineHeight: 44,
    letterSpacingPercent: -2,
    fontWeight: weight,
  );

  static TextStyle h5({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 30, lineHeight: 38, fontWeight: weight);

  static TextStyle h6({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 24, lineHeight: 32, fontWeight: weight);

  // ==========================================
  // Body Text - For Paragraphs, Buttons & Labels
  // ==========================================

  static TextStyle bodyExtraLarge({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 20, lineHeight: 30, fontWeight: weight);

  static TextStyle bodyLarge({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 18, lineHeight: 28, fontWeight: weight);

  static TextStyle bodyMedium({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 16, lineHeight: 24, fontWeight: weight);

  static TextStyle bodySmall({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 14, lineHeight: 20, fontWeight: weight);

  static TextStyle bodyExtraSmall({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 12, lineHeight: 18, fontWeight: weight);

  static TextStyle caption({FontWeight weight = regular}) =>
      _baseStyle(fontSize: 12, lineHeight: 16, fontWeight: weight);
}
