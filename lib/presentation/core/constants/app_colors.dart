import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

class AppColors extends Equatable {
  const AppColors._({
    required this.background,
    required this.primary,
    required this.disabled,
    required this.secondary,
    required this.tertiary,
    required this.accent,
    required this.greenPrimary,
    required this.borderPrimary,
    required this.borderSecondary,
    required this.surfacePrimary,
    required this.surfaceSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.whiteBase,
    required this.blackBase,
    required this.grayBase,
    required this.sheetsBackground,
    required this.redBase,
    required this.greenBase,
    required this.orangeBase,
    required this.purpleBase,
  });

  factory AppColors.light() {
    return const AppColors._(
      background: Color(0xffFCFCFC),
      primary: Color(0xFF2ED87B),
      secondary: Color(0xFF28C16D),
      tertiary: Color(0xFF21A85B),
      disabled: Color(0xFFEBEBE4),
      accent: Color(0xff000000),
      greenPrimary: Color(0xff199A5E),
      borderPrimary: Color(0xFFE1E4E9),
      borderSecondary: Color(0xFFD4D7DC),
      surfacePrimary: Color(0xFFEFF1F2),
      surfaceSecondary: Color(0xFFCCCED2),
      textPrimary: Color(0xFF1A1A1A),
      textSecondary: Color(0xFF8390A1),
      textTertiary: Color(0xffA2ABBA),
      textDisabled: Color(0xFFD0D0D0),
      whiteBase: Color(0xffFFFFFF),
      blackBase: Color(0xff000000),
      grayBase: Color(0xFFD8D8D8),
      sheetsBackground: Color(0xffFFFFFF),
      redBase: Color(0xFFEC5C5C),
      greenBase: Color(0xFF32A164),
      orangeBase: Color(0xffFB8C00),
      purpleBase: Color(0xFF6A4C93),
    );
  }

  factory AppColors.dark() {
    return const AppColors._(
      background: Color(0xFF1E1E1E),
      primary: Color(0xFF2ED87B),
      secondary: Color(0xFF28C16D),
      tertiary: Color(0xFF21A85B),
      disabled: Color(0x60303030),
      accent: Color(0xFFE0E0E0),
      greenPrimary: Color(0xFF199A5E),
      borderPrimary: Color(0xFF3C3C3C),
      borderSecondary: Color(0xFF555555),
      surfacePrimary: Color(0xFF1C1C1C),
      surfaceSecondary: Color(0xFF2B2B2B),
      textPrimary: Color(0xFFFFFFFF),
      textSecondary: Color(0xFFC4C4C4),
      textTertiary: Color(0xFFA2ABBA),
      textDisabled: Color(0xFFD0D0D0),
      whiteBase: Color(0xffFFFFFF),
      blackBase: Color(0xff000000),
      grayBase: Color(0xFFD8D8D8),
      sheetsBackground: Color(0xFF1E1E1E),
      redBase: Color(0xFFEC5C5C),
      greenBase: Color(0xFF32A164),
      orangeBase: Color(0xffFB8C00),
      purpleBase: Color(0xFF6A4C93),
    );
  }

  final Color background;
  final Color primary;
  final Color disabled;
  final Color secondary;
  final Color tertiary;
  final Color accent;
  final Color borderPrimary;
  final Color borderSecondary;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color whiteBase;
  final Color blackBase;
  final Color grayBase;
  final Color greenPrimary;
  final Color sheetsBackground;
  final Color redBase;
  final Color greenBase;
  final Color orangeBase;
  final Color purpleBase;

  @override
  List<Object> get props {
    return [
      background,
      primary,
      disabled,
      secondary,
      tertiary,
      accent,
      borderPrimary,
      borderSecondary,
      surfacePrimary,
      surfaceSecondary,
      textPrimary,
      textSecondary,
      textTertiary,
      textDisabled,
      whiteBase,
      blackBase,
      grayBase,
      greenPrimary,
      sheetsBackground,
      redBase,
      greenBase,
      orangeBase,
      purpleBase,
    ];
  }
}
