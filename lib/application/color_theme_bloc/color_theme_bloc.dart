import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'color_theme_event.dart';
part 'color_theme_state.dart';

class ColorThemeBloc extends Bloc<ColorThemeEvent, ColorThemeState> {
  ColorThemeBloc(this._iCacheController)
      : super(const ColorThemeInitialState()) {
    on<ColorThemeInitializedEvent>(
      _onInitialized,
      transformer: droppable(),
    );
    on<ColorThemeEvent>(
      (event, emit) async {
        if (event is ColorThemeLightSelectedEvent) {
          await _onLightSelected(event, emit);
        } else if (event is ColorThemeDarkSelectedEvent) {
          await _onDarkSelected(event, emit);
        } else if (event is ColorThemeSystemSelectedEvent) {
          await _onSystemSelected(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  void addInitialized() {
    add(ColorThemeInitializedEvent());
  }

  void addLightSelected() {
    add(ColorThemeLightSelectedEvent());
  }

  void addDarkSelected() {
    add(ColorThemeDarkSelectedEvent());
  }

  void addSystemSelected() {
    add(ColorThemeSystemSelectedEvent());
  }

  Future<void> _onInitialized(
    ColorThemeInitializedEvent event,
    Emitter<ColorThemeState> emit,
  ) async {
    return emit(const ColorThemeLightState());
    //* Uncomment when dark theme is ready
/*     final theme = _iCacheController.readInt(key: CacheKey.COLOR_THEME);

    if (theme == _light) {
      emit(const ColorThemeLightState());
    } else if (theme == _dark) {
      emit(const ColorThemeDarkState());
    } else if (theme == _system) {
      emit(const ColorThemeSystemState());
    } else {
      emit(const ColorThemeSystemState());
    } */
  }

  Future<void> _onLightSelected(
    ColorThemeLightSelectedEvent event,
    Emitter<ColorThemeState> emit,
  ) async {
    await _iCacheController.writeInt(
      key: CacheKey.COLOR_THEME,
      value: _light,
    );

    emit(const ColorThemeLightState());
  }

  Future<void> _onDarkSelected(
    ColorThemeDarkSelectedEvent event,
    Emitter<ColorThemeState> emit,
  ) async {
    await _iCacheController.writeInt(
      key: CacheKey.COLOR_THEME,
      value: _dark,
    );

    emit(const ColorThemeDarkState());
  }

  Future<void> _onSystemSelected(
    ColorThemeSystemSelectedEvent event,
    Emitter<ColorThemeState> emit,
  ) async {
    await _iCacheController.writeInt(
      key: CacheKey.COLOR_THEME,
      value: _system,
    );

    emit(const ColorThemeSystemState());
  }

  final ICacheController _iCacheController;

  static const _dark = -1;
  static const _light = 1;
  static const _system = 0;
}
