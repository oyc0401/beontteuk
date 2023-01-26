import 'package:flutter/material.dart';

class LetterStyle extends TextStyle {
  const LetterStyle({
    super.inherit = true,
    super.color,
    super.backgroundColor,
    required this.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.fontVariations,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    super.overflow,
  }) : super(
          fontSize: fontSize,
          letterSpacing: fontSize * -0.02,
        );

  @override
  final double fontSize;
}
