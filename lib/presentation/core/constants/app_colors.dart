import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

class AppColors extends Equatable {
  const AppColors._({
    required this.background,
    required this.primary,
    required this.primaryDisabled,
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
    required this.whiteBase,
    required this.blackBase,
    required this.surfaceSelected,
    required this.sheetsBackground,
    required this.error,
    required this.success,
  });
  factory AppColors.light() {
    return const AppColors._(
      background: Color(0xffFCFCFC),
      primary: Color(0xFF2ED87B),
      primaryDisabled: Color(0xFFC9F1F3),
      secondary: Color(0xffE9FBFB),
      tertiary: Color(0xff19898F),
      accent: Color(0xff000000),
      greenPrimary: Color(0xff199A5E),
      borderPrimary: Color(0xFFE1E4E9),
      borderSecondary: Color(0xFFD4D7DC),
      surfacePrimary: Color(0xFFF7F8F9),
      surfaceSecondary: Color(0xFFE0E3E8),
      surfaceSelected: Color(0xffE9FBFB),
      textPrimary: Color(0xFF1A1A1A),
      textSecondary: Color(0xFF8390A1),
      textTertiary: Color(0xffA2ABBA),
      whiteBase: Color(0xffFFFFFF),
      blackBase: Color(0xff000000),
      sheetsBackground: Color(0xffFFFFFF),
      error: Color(0xFFEC5C5C),
      success: Color(0xFF32A164),
    );
  }
  factory AppColors.dark() {
    return const AppColors._(
      background: Color(0xFF1E1E1E),
      primary: Color(0xFF14B1B9),
      primaryDisabled: Color(0xFF3C6165),
      secondary: Color(0xFF273C3C),
      tertiary: Color(0xFF19898F),
      accent: Color(0xFFE0E0E0),
      greenPrimary: Color(0xFF199A5E),
      borderPrimary: Color(0xFF3C3C3C),
      borderSecondary: Color(0xFF555555),
      surfacePrimary: Color(0xFF1C1C1C),
      surfaceSecondary: Color(0xFF2B2B2B),
      surfaceSelected: Color(0xFF273C3C),
      textPrimary: Color(0xFFFFFFFF),
      textSecondary: Color(0xFFC4C4C4),
      textTertiary: Color(0xFFA2ABBA),
      whiteBase: Color(0xffFFFFFF),
      blackBase: Color(0xff000000),
      sheetsBackground: Color(0xFF1E1E1E),
      error: Color(0xFFEC5C5C),
      success: Color(0xFF32A164),
    );
  }

  final Color background;
  final Color primary;
  final Color primaryDisabled;
  final Color secondary;
  final Color tertiary;
  final Color accent;
  final Color borderPrimary;
  final Color borderSecondary;
  final Color surfacePrimary;
  final Color surfaceSecondary;
  final Color surfaceSelected;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color whiteBase;
  final Color blackBase;
  final Color greenPrimary;
  final Color sheetsBackground;
  final Color error;
  final Color success;

  @override
  List<Object> get props {
    return [
      background,
      primary,
      primaryDisabled,
      secondary,
      tertiary,
      accent,
      borderPrimary,
      borderSecondary,
      surfacePrimary,
      surfaceSecondary,
      surfaceSelected,
      textPrimary,
      textSecondary,
      textTertiary,
      whiteBase,
      blackBase,
      greenPrimary,
      sheetsBackground,
      error,
      success,
    ];
  }
}
