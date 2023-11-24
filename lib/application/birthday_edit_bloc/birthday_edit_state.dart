part of 'birthday_edit_bloc.dart';

final class BirthdayEditState extends Equatable {
  const BirthdayEditState({
    required this.birthdayOption,
    required this.errorOption,
    required this.validating,
    required this.langCode,
  });

  factory BirthdayEditState.initial() {
    return BirthdayEditState(
      birthdayOption: none(),
      errorOption: none(),
      validating: false,
      langCode: '',
    );
  }

  BirthdayEditState copyWith({
    Option<DateTime>? birthdayOption,
    Option<String?>? errorOption,
    bool? validating,
    String? langCode,
  }) {
    return BirthdayEditState(
      birthdayOption: birthdayOption ?? this.birthdayOption,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
      langCode: langCode ?? this.langCode,
    );
  }

  final Option<DateTime> birthdayOption;
  final Option<String?> errorOption;
  final bool validating;
  final String langCode;

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

  DateTime? get birthdayDateOrNull => birthdayOption.fold(() => null, id);

  String get birthdayOrEmpty => birthdayOption.fold(
        () => '',
        (date) {
          if (langCode == LocaleType.TR.value) {
            return '${date.day}/${date.month}/${date.year}';
          } else {
            return '${date.month}/${date.day}/${date.year}';
          }
        },
      );

  @override
  List<Object?> get props => [
        birthdayOption,
        errorOption,
        validating,
        langCode,
      ];
}
