part of "splash_bloc.dart";

abstract class SplashEvent extends Equatable {
  const SplashEvent();
  @override
  List<Object?> get props => [];
}

final class _SplashCheckAppStateEvent extends SplashEvent {
  const _SplashCheckAppStateEvent();
}
