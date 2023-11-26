part of 'avatar_edit_bloc.dart';

sealed class AvatarEditEvent extends Equatable {
  const AvatarEditEvent();

  @override
  List<Object> get props => [];
}

class _AvatarUpdatedEvent extends AvatarEditEvent {
  const _AvatarUpdatedEvent({required this.avatarUrl});

  final String avatarUrl;

  @override
  List<Object> get props => [avatarUrl];
}
