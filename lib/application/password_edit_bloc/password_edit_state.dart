part of 'password_edit_bloc.dart';

final class PasswordEditState extends Equatable {
  const PasswordEditState({
    required this.passwordOption,
    required this.errorOption,
    required this.validating,
    required this.hidePassword,
  });

  factory PasswordEditState.initial() {
    return PasswordEditState(
      passwordOption: none(),
      errorOption: none(),
      validating: false,
      hidePassword: true,
    );
  }

  PasswordEditState copyWith({
    Option<String>? passwordOption,
    Option<String?>? errorOption,
    bool? validating,
    bool? hidePassword,
  }) {
    return PasswordEditState(
      passwordOption: passwordOption ?? this.passwordOption,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }

  final Option<String> passwordOption;
  final Option<String?> errorOption;
  final bool validating;
  final bool hidePassword;

  String get passwordOrEmpty => passwordOption.getOrElse(() => '');

  bool get isFormValid => errorOption.fold(
        () {
          return false;
        },
        (errorMessage) {
          if (errorMessage == null) {
            return true;
          } else {
            return false;
          }
        },
      );

  String? get errorText => errorOption.fold(
        () => null,
        (errorText) => errorText,
      );

  @override
  List<Object?> get props => [
        passwordOption,
        errorOption,
        validating,
        hidePassword,
      ];
}
