part of 'avatar_edit_bloc.dart';

sealed class AvatarEditEvent extends Equatable {
  const AvatarEditEvent();

  @override
  List<Object> get props => [];
}

class _AvatarUpdatedEvent extends AvatarEditEvent {
  const _AvatarUpdatedEvent({required this.avatarFile});

  final File avatarFile;

  @override
  List<Object> get props => [avatarFile];
}
