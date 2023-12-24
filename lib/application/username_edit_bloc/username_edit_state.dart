part of 'username_edit_bloc.dart';

final class UsernameEditState extends Equatable {
  const UsernameEditState({
    required this.usernameOption,
    required this.errorOption,
    required this.validating,
  });

  factory UsernameEditState.initial() {
    return UsernameEditState(
      usernameOption: none(),
      errorOption: none(),
      validating: false,
    );
  }

  UsernameEditState copyWith({
    Option<String>? usernameOption,
    Option<String?>? errorOption,
    bool? validating,
  }) {
    return UsernameEditState(
      usernameOption: usernameOption ?? this.usernameOption,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
    );
  }

  final Option<String> usernameOption;
  final Option<String?> errorOption;
  final bool validating;

  String get usernameOrEmpty => usernameOption.getOrElse(() => '');

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
  List<Object?> get props => [usernameOption, errorOption, validating];
}
