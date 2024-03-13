import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/infrastructure/repository/event_repository/i_event_repository.dart';
import 'package:event_mate/model/interest_category_data.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

part 'interests_edit_event.dart';
part 'interests_edit_state.dart';

class InterestsEditBloc extends Bloc<InterestsEditEvent, InterestsEditState> {
  InterestsEditBloc(this._iEventRepository)
      : super(InterestsEditState.initial()) {
    on<_InterestsFetchCategoriesEvent>(
      _onInterestsFetchCategories,
      transformer: droppable(),
    );
    on<_InterestsValidatedEvent>(
      _onInterestsValidatedEvent,
      transformer: sequential(),
    );
    on<_InterestToggledEvent>(
      _onInterestToggledEvent,
      transformer: droppable(),
    );
  }

  final IEventRepository _iEventRepository;

  void addFetchCategories() {
    add(const _InterestsFetchCategoriesEvent());
  }

  void addInterestToggled({required InterestCategoryData interest}) {
    add(_InterestToggledEvent(interest: interest));
  }

  void addInterestsValidate() {
    add(const _InterestsValidatedEvent());
  }

  FutureOr<void> _onInterestToggledEvent(
    _InterestToggledEvent event,
    Emitter<InterestsEditState> emit,
  ) {
    final selectedInterests = state.selectedInterests;
    emit(
      state.copyWith(
        selectedInterests: selectedInterests.contains(event.interest)
            ? selectedInterests.minusElement(event.interest)
            : selectedInterests.plusElement(event.interest),
      ),
    );
  }

  FutureOr<void> _onInterestsValidatedEvent(
    _InterestsValidatedEvent event,
    Emitter<InterestsEditState> emit,
  ) {
    emit(state.copyWith(validating: true));
    emit(
      state.copyWith(
        validating: false,
        errorOption: state.selectedInterests.size < 3
            ? some('registration.interests_size_error_message')
            : some(null),
      ),
    );
  }

  Future<void> _onInterestsFetchCategories(
    _InterestsFetchCategoriesEvent event,
    Emitter<InterestsEditState> emit,
  ) async {
    emit(state.copyWith(failureOrInterestListOption: none()));

    final failureOrCategories =
        await _iEventRepository.getAllInterestCategories();

    emit(
      state.copyWith(
        failureOrInterestListOption: some(failureOrCategories),
      ),
    );
  }
}
