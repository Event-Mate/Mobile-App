import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/repository/registration_repository_failure.dart';
import 'package:event_mate/infrastructure/repository/i_registration_repository.dart';
import 'package:event_mate/model/user_information.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc(
    this._iRegistrationRepository,
  ) : super(RegistrationState.initial()) {
    on<EmailRegisterEvent>(
      _onEmailRegisterEvent,
    );
  }
  final IRegistrationRepository _iRegistrationRepository;

  Future<void> _onEmailRegisterEvent(
    EmailRegisterEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    final failureOrUnit =
        await _iRegistrationRepository.registerUser(userInfo: event.user);
    emit(state.copyWith(processFailureOrUnitOption: some(failureOrUnit)));
  }
}
