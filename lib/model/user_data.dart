import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:event_mate/core/enums/gender_type.dart';

class UserData extends Equatable {
  // TODO(Furkan): Avatar file key ?
  const UserData({
    required this.displayName,
    required this.username,
    required this.email,
    required this.password,
    required this.genderType,
    required this.dateOfBirth,
    required this.avatarFile,
  });

  // TODO(Furkan): receiving model may be updated
  factory UserData.fromMap(Map<String, dynamic> json) {
    return UserData(
      displayName: json['fullName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      genderType: GenderType.fromValue(json['gender'] as String),
      dateOfBirth: json['dateOfBirth'] as DateTime,
      avatarFile: json['avatar_url'] as File?,
    );
  }

  factory UserData.empty() {
    return UserData(
      displayName: '',
      username: '',
      email: '',
      password: '',
      genderType: GenderType.NONE,
      dateOfBirth: DateTime.now(),
      avatarFile: null,
    );
  }

  final String displayName;
  final String username;
  final String email;
  final String password;
  final GenderType genderType;
  final DateTime dateOfBirth;
  final File? avatarFile;

  Map<String, String> toMap() {
    return {
      'fullName': displayName,
      'username': username,
      'email': email,
      'password': password,
      'gender': genderType.value,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      // 'avatar': avatarFile,
    };
  }

  UserData copyWith({
    String? displayName,
    String? username,
    String? email,
    String? password,
    GenderType? genderType,
    DateTime? dateOfBirth,
    File? avatarFile,
  }) {
    return UserData(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      genderType: genderType ?? this.genderType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
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
        avatarFile,
      ];
}
