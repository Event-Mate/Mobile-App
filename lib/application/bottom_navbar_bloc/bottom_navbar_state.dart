part of 'bottom_navbar_bloc.dart';

abstract class BottomNavbarState extends Equatable {
  const BottomNavbarState({required this.selectedIndex});
  final int selectedIndex;

  Map<int, BottomNavbarState> get indexStateMap => {
        BottomNavbarHomePageState.index: const BottomNavbarHomePageState(),
        BottomNavbarEventsPageState.index: const BottomNavbarEventsPageState(),
        BottomNavbarSocialPageState.index: const BottomNavbarSocialPageState(),
        BottomNavbarProfilePageState.index:
            const BottomNavbarProfilePageState(),
      };

  @override
  List<Object> get props => [selectedIndex];
}

final class BottomNavbarHomePageState extends BottomNavbarState {
  const BottomNavbarHomePageState() : super(selectedIndex: index);
  static const index = 0;
}

final class BottomNavbarEventsPageState extends BottomNavbarState {
  const BottomNavbarEventsPageState() : super(selectedIndex: index);
  static const index = 1;
}

final class BottomNavbarSocialPageState extends BottomNavbarState {
  const BottomNavbarSocialPageState() : super(selectedIndex: index);
  static const index = 2;
}

final class BottomNavbarProfilePageState extends BottomNavbarState {
  const BottomNavbarProfilePageState() : super(selectedIndex: index);
  static const index = 3;
}
