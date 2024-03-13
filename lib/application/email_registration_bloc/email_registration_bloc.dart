import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/cache_key.dart';
import 'package:event_mate/infrastructure/controller/cache_controller/i_cache_controller.dart';
import 'package:event_mate/infrastructure/repository/registration_repository/i_registration_repository.dart';
import 'package:event_mate/infrastructure/storage/user_data_storage/i_user_data_storage.dart';
import 'package:event_mate/model/registration_data.dart';
import 'package:event_mate/presentation/authentication/registration/enum/registration_step_type.dart';
import 'package:event_mate/presentation/authentication/registration/registration_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_registration_event.dart';
part 'email_registration_state.dart';

class EmailRegistrationBloc
    extends Bloc<EmailRegistrationEvent, EmailRegistrationState> {
  EmailRegistrationBloc(
    this._iRegistrationRepository,
    this._iUserDataStorage,
    this._iCacheController,
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
  final IUserDataStorage _iUserDataStorage;
  final ICacheController _iCacheController;

  void addPreviousStep() {
    add(const _NavigatedToPreviousStep());
  }

  /// [registrationData] is the data that involves the user's registration data up to the current step.
  void addNextStep({required RegistrationData registrationData}) {
    add(_NavigatedToNextStep(registrationData: registrationData));
  }

  void addCompleteRegistration({required RegistrationData registrationData}) {
    add(_RegistrationCompletedEvent(registrationData: registrationData));
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
      registrationData: event.registrationData,
    ));
  }

  Future<void> _onRegisterCompletedEvent(
    _RegistrationCompletedEvent event,
    Emitter<EmailRegistrationState> emit,
  ) async {
    emit(state.copyWith(processFailureOrUnitOption: none(), completing: true));

    final failureOrUserDataWToken = await _iRegistrationRepository.registerUser(
      registrationData: event.registrationData,
    );

    log('failureOrUserDataWToken: $failureOrUserDataWToken');

    final newState = await failureOrUserDataWToken.fold(
      (failure) async {
        return state.copyWith(processFailureOrUnitOption: some(left(failure)));
      },
      (userDataWithToken) async {
        final userData = userDataWithToken.value1;
        final token = userDataWithToken.value2;

        await _iCacheController.writeString(
          key: CacheKey.UID,
          value: userData.id,
        );

        await _iCacheController.writeString(
          key: CacheKey.ACCESS_TOKEN,
          value: token,
        );

        final failureOrUnit = await _iUserDataStorage.put(
          uniqueId: userData.id,
          userData: userData,
        );

        return state.copyWith(processFailureOrUnitOption: some(failureOrUnit));
      },
    );

    emit(newState.copyWith(completing: false));
  }
}
