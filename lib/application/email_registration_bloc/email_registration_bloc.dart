import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/model/user_data.dart';
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
    on<_RegistrationCompletedEvent>(
      _onRegisterCompletedEvent,
    );
  }
  final IRegistrationRepository _iRegistrationRepository;

  void addPreviousStep() {
    add(const _NavigatedToPreviousStep());
  }

  /// [userData] is the data that involves past and current step data.
  void addNextStep({required UserData userData}) {
    add(_NavigatedToNextStep(userData: userData));
  }

  void addCompleteRegistration({required UserData user}) {
    add(_RegistrationCompletedEvent(userData: user));
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
    emit(state.copyWith(
      currentStepIndex: state.currentStepIndex + 1,
      userData: event.userData,
    ));
  }

  Future<void> _onRegisterCompletedEvent(
    _RegistrationCompletedEvent event,
    Emitter<EmailRegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        processFailureOrUnitOption: none(),
        completing: true,
      ),
    );
    log('event.userData: ${event.userData}');
    final failureOrUnit =
        await _iRegistrationRepository.registerUser(userData: event.userData);
    log('failureOrUnit: $failureOrUnit');
    emit(
      state.copyWith(
        processFailureOrUnitOption: some(failureOrUnit),
        completing: false,
      ),
    );
  }
}
