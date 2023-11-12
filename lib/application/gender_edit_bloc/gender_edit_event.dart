part of 'gender_edit_bloc.dart';

sealed class GenderEditEvent extends Equatable {
  const GenderEditEvent();

  @override
  List<Object> get props => [];
}

class _GenderUpdatedEvent extends GenderEditEvent {
  const _GenderUpdatedEvent({required this.gender});

  final GenderType gender;

  @override
  List<Object> get props => [gender];
}

class _GenderValidatedEvent extends GenderEditEvent {
  const _GenderValidatedEvent();
}
