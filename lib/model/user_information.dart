import 'package:equatable/equatable.dart';

class UserInformation extends Equatable {
  const UserInformation({
    required this.displayName,
    required this.username,
    required this.email,
    required this.avatarUrl,
  });

  factory UserInformation.fromMap(Map<String, dynamic> json) {
    return UserInformation(
      displayName: json['display_name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }
  final String displayName;
  final String username;
  final String email;
  final String? avatarUrl;

  Map<String, dynamic> toMap() {
    return {
      'display_name': displayName,
      'username': username,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [displayName, username, email, avatarUrl];
}
