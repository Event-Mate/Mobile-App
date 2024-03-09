import 'package:equatable/equatable.dart';
import 'package:event_mate/core/enums/gender_type.dart';
import 'package:event_mate/environment.dart' as env;
import 'package:event_mate/infrastructure/storage/user_data_storage/user_data_storage.dart';

class UserData extends Equatable {
  const UserData({
    required this.id,
    required this.displayName,
    required this.username,
    required this.email,
    required this.genderType,
    required this.dateOfBirth,
    required this.avatarUrl,
  });

  /// Factory constructor that will be used when data is received from the [RegistrationRepository].
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['_id'] as String,
      displayName: map['fullName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      genderType: GenderType.fromValue(map['gender'] as String),
      dateOfBirth: DateTime.parse(map['dateOfBirth'] as String),
      avatarUrl: '${env.AWS_ASSETS_HOST}/${map['avatar'] as String}',
    );
  }

  /// Factory constructor that will be used when data is received from the [UserDataStorage].
  factory UserData.fromJSON(Map<String, dynamic> map) {
    return UserData(
      id: map['_id'] as String,
      displayName: map['fullName'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      genderType: GenderType.fromValue(map['gender'] as String),
      dateOfBirth: DateTime.parse(map['dateOfBirth'] as String),
      avatarUrl: map['avatar'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'fullName': displayName,
      'username': username,
      'email': email,
      'gender': genderType.value,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'avatar': avatarUrl,
    };
  }

  final String id;
  final String displayName;
  final String username;
  final String email;
  final GenderType genderType;
  final DateTime dateOfBirth;
  final String avatarUrl;

  UserData copyWith({
    String? id,
    String? displayName,
    String? username,
    String? email,
    String? password,
    GenderType? genderType,
    DateTime? dateOfBirth,
    String? avatarUrl,
  }) {
    return UserData(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      email: email ?? this.email,
      genderType: genderType ?? this.genderType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  String get dateOfBirthStr => dateOfBirth.toString().split(' ').first;

  @override
  List<Object?> get props => [
        id,
        displayName,
        username,
        email,
        genderType,
        dateOfBirth,
        avatarUrl,
      ];

  @override
  bool? get stringify => true;
}
