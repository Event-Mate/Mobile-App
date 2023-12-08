import 'package:equatable/equatable.dart';
import 'package:event_mate/core/enums/gender_type.dart';

class UserData extends Equatable {
  const UserData({
    required this.displayName,
    required this.username,
    required this.email,
    required this.genderType,
    required this.dateOfBirth,
    required this.avatar,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      displayName: map['fullName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      genderType: GenderType.fromValue(map['gender'] as String),
      dateOfBirth: DateTime.parse(map['dateOfBirth'] as String),
      avatar: map['avatar'] as String,
    );
  }

  final String displayName;
  final String username;
  final String email;
  final GenderType genderType;
  final DateTime dateOfBirth;
  final String avatar;

  UserData copyWith({
    String? displayName,
    String? username,
    String? email,
    String? password,
    GenderType? genderType,
    DateTime? dateOfBirth,
    String? avatar,
  }) {
    return UserData(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      genderType: genderType ?? this.genderType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        displayName,
        username,
        email,
        genderType,
        dateOfBirth,
        avatar,
      ];
}
