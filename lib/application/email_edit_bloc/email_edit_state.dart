part of 'email_edit_bloc.dart';

final class EmailEditState extends Equatable {
  const EmailEditState({
    required this.emailOption,
    required this.errorOption,
    required this.validating,
  });

  factory EmailEditState.initial() {
    return EmailEditState(
      emailOption: none(),
      errorOption: none(),
      validating: false,
    );
  }

  EmailEditState copyWith({
    Option<String>? emailOption,
    Option<String?>? errorOption,
    bool? validating,
  }) {
    return EmailEditState(
      emailOption: emailOption ?? this.emailOption,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
    );
  }

  final Option<String> emailOption;
  final Option<String?> errorOption;
  final bool validating;

  String get emailOrEmpty => emailOption.getOrElse(() => '');

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
  List<Object?> get props => [emailOption, errorOption, validating];
}
