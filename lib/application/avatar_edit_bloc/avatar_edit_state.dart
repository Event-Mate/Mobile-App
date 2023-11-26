part of 'avatar_edit_bloc.dart';

final class AvatarEditState extends Equatable {
  const AvatarEditState({
    required this.avatarOption,
  });

  factory AvatarEditState.initial() {
    return AvatarEditState(
      avatarOption: none(),
    );
  }

  AvatarEditState copyWith({
    Option<String>? avatarOption,
  }) {
    return AvatarEditState(
      avatarOption: avatarOption ?? this.avatarOption,
    );
  }

  final Option<String> avatarOption;

  @override
  List<Object?> get props => [avatarOption];
}
