part of 'name_edit_bloc.dart';

sealed class NameEditEvent extends Equatable {
  const NameEditEvent();

  @override
  List<Object> get props => [];
}

class _NameUpdatedEvent extends NameEditEvent {
  const _NameUpdatedEvent({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class _NameValidatedEvent extends NameEditEvent {
  const _NameValidatedEvent();
}
