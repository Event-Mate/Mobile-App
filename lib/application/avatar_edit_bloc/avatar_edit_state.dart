part of 'avatar_edit_bloc.dart';

final class AvatarEditState extends Equatable {
  const AvatarEditState({required this.avatarOption});

  factory AvatarEditState.initial() {
    return AvatarEditState(avatarOption: none());
  }

  AvatarEditState copyWith({
    Option<File>? avatarOption,
  }) {
    return AvatarEditState(
      avatarOption: avatarOption ?? this.avatarOption,
    );
  }

  final Option<File> avatarOption;

  File? get avatarOrNull => avatarOption.fold(() => null, id);

  @override
  List<Object?> get props => [avatarOption];
}
