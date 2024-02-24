part of 'bottom_navbar_bloc.dart';

sealed class BottomNavbarEvent extends Equatable {
  const BottomNavbarEvent();

  @override
  List<Object> get props => [];
}

final class _UpdateIndexBottomNavbarEvent extends BottomNavbarEvent {
  const _UpdateIndexBottomNavbarEvent({required this.index});
  final int index;

  @override
  List<Object> get props => [index];
}
