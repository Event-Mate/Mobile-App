import 'package:event_mate/application/color_theme_bloc/color_theme_bloc.dart';
import 'package:event_mate/presentation/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextThemeExt on BuildContext {
  AppColors get colors {
    final state = read<ColorThemeBloc>().state;
    if (state is ColorThemeDarkState) {
      return AppColors.dark();
    } else if (state is ColorThemeLightState) {
      return AppColors.light();
    } else if (state is ColorThemeSystemState) {
      final platformBrightness = MediaQuery.platformBrightnessOf(this);
      if (platformBrightness == Brightness.dark) {
        return AppColors.dark();
      } else {
        return AppColors.light();
      }
    } else {
      return AppColors.light();
    }
  }
}
