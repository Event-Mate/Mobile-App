import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/model/user_information.dart';
import 'package:event_mate/presentation/authentication/registration/enum/registration_step_type.dart';
import 'package:event_mate/presentation/authentication/registration/registration_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_registration_event.dart';
part 'email_registration_state.dart';

class EmailRegistrationBloc
    extends Bloc<EmailRegistrationEvent, EmailRegistrationState> {
  EmailRegistrationBloc(
    this._iRegistrationRepository,
  ) : super(EmailRegistrationState.initial()) {
    on<_NavigatedToPreviousStep>(
      _onNavigatedToPreviousStep,
    );
    on<_NavigatedToNextStep>(
      _onNavigatedToNextStep,
    );
    on<_RegisterCompletedEvent>(
      _onRegisterCompletedEvent,
    );
  }
  final IRegistrationRepository _iRegistrationRepository;

  void addUsernameUpdated({required String username}) {
    add(_UsernameUpdatedEvent(username: username));
  }

  void addPreviousStep() {
    add(const _NavigatedToPreviousStep());
  }

  void addNextStep() {
    add(const _NavigatedToNextStep());
  }

  Future<void> _onNavigatedToPreviousStep(
    _NavigatedToPreviousStep event,
    Emitter<EmailRegistrationState> emit,
  ) async {
    emit(state.copyWith(currentStepIndex: state.currentStepIndex - 1));
  }

  Future<void> _onNavigatedToNextStep(
    _NavigatedToNextStep event,
    Emitter<EmailRegistrationState> emit,
  ) async {
    emit(state.copyWith(currentStepIndex: state.currentStepIndex + 1));
  }

  Future<void> _onRegisterCompletedEvent(
    _RegisterCompletedEvent event,
    Emitter<EmailRegistrationState> emit,
  ) async {
    final failureOrUnit =
        await _iRegistrationRepository.registerUser(userInfo: event.user);
    emit(state.copyWith(processFailureOrUnitOption: some(failureOrUnit)));
  }
}
