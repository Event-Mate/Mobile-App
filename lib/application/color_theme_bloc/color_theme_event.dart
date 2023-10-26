part of 'color_theme_bloc.dart';

abstract class ColorThemeEvent extends Equatable {}

final class ColorThemeInitializedEvent extends ColorThemeEvent {
  @override
  List<Object?> get props => [];
}

final class ColorThemeLightSelectedEvent extends ColorThemeEvent {
  @override
  List<Object?> get props => [];
}

final class ColorThemeDarkSelectedEvent extends ColorThemeEvent {
  @override
  List<Object?> get props => [];
}

final class ColorThemeSystemSelectedEvent extends ColorThemeEvent {
  @override
  List<Object?> get props => [];
}
