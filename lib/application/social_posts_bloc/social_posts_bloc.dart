import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_mate/failure/core/custom_failure.dart';
import 'package:event_mate/infrastructure/repository/social_repository/i_social_repository.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/model/post_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

part 'social_posts_event.dart';
part 'social_posts_state.dart';

class SocialPostsBloc extends Bloc<SocialPostsEvent, SocialPostsState> {
  SocialPostsBloc(
    this._iSocialRepository,
  ) : super(SocialPostsState.initial()) {
    on<FetchAllPosts>(
      _onFetchAllPosts,
      transformer: droppable(),
    );
    on<CreatePost>(
      _onCreatePost,
      transformer: droppable(),
    );
  }

  void addFetchAllPosts() {
    add(const FetchAllPosts());
  }

  void addCreatePost({
    required String content,
    required EventData eventData,
  }) {
    add(CreatePost(content: content, eventData: eventData));
  }

  final ISocialRepository _iSocialRepository;

  Future<void> _onFetchAllPosts(
    FetchAllPosts event,
    Emitter<SocialPostsState> emit,
  ) async {
    emit(state.copyWith(failureOrPostListOption: none()));

    final failureOrPostList = await _iSocialRepository.getAll();

    emit(state.copyWith(failureOrPostListOption: some(failureOrPostList)));
  }

  Future<void> _onCreatePost(
    CreatePost event,
    Emitter<SocialPostsState> emit,
  ) async {
    emit(state.copyWith(failureOrUnitOption: none()));

    final failureOrUnit = await _iSocialRepository.createPost(
      content: event.content,
      eventData: event.eventData,
    );

    emit(state.copyWith(failureOrUnitOption: some(failureOrUnit)));
  }
}
