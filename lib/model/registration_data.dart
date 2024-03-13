import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:event_mate/core/enums/gender_type.dart';
import 'package:event_mate/model/interest_category_data.dart';
import 'package:kt_dart/kt.dart';

class RegistrationData extends Equatable {
  const RegistrationData({
    required this.displayName,
    required this.username,
    required this.email,
    required this.password,
    required this.genderType,
    required this.dateOfBirth,
    required this.interests,
    required this.avatarFile,
  });

  factory RegistrationData.empty() {
    return RegistrationData(
      displayName: '',
      username: '',
      email: '',
      password: '',
      genderType: GenderType.NONE,
      dateOfBirth: DateTime.now(),
      interests: const KtList.empty(),
      avatarFile: null,
    );
  }

  final String displayName;
  final String username;
  final String email;
  final String password;
  final GenderType genderType;
  final DateTime dateOfBirth;
  final KtList<InterestCategoryData> interests;
  final File? avatarFile;

  //* This doesn't involve avatar file, attach it to multipart request as a file.
  Map<String, String> toMap() {
    final interests = jsonEncode(this.interests.map((e) => e.toMap()).asList());
    return {
      'fullName': displayName,
      'username': username,
      'email': email,
      'password': password,
      'gender': genderType.value,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'interests': interests,
    };
  }

  RegistrationData copyWith({
    String? displayName,
    String? username,
    String? email,
    String? password,
    GenderType? genderType,
    DateTime? dateOfBirth,
    KtList<InterestCategoryData>? interests,
    File? avatarFile,
  }) {
    return RegistrationData(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      genderType: genderType ?? this.genderType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      interests: interests ?? this.interests,
      avatarFile: avatarFile ?? this.avatarFile,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        displayName,
        username,
        email,
        password,
        genderType,
        dateOfBirth,
        interests,
        avatarFile,
      ];
}
