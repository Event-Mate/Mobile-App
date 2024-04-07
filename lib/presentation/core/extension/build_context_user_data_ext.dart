import 'package:event_mate/application/authentication_bloc/authentication_bloc.dart';
import 'package:event_mate/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildContextUserDataExt on BuildContext {
  AuthenticationState get auth => read<AuthenticationBloc>().state;

  UserData get userData => auth.userData;
}
