part of 'my_profile_bloc.dart';

sealed class MyProfileEvent extends Equatable {
  const MyProfileEvent();

  @override
  List<Object> get props => [];
}

class _MyProfileFetchEvent extends MyProfileEvent {
  const _MyProfileFetchEvent();
}
