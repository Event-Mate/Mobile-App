part of 'name_edit_bloc.dart';

final class NameEditState extends Equatable {
  const NameEditState({
    required this.nameOption,
    required this.errorOption,
    required this.validating,
  });

  factory NameEditState.initial() {
    return NameEditState(
      nameOption: none(),
      errorOption: none(),
      validating: false,
    );
  }

  NameEditState copyWith({
    Option<String>? nameOption,
    Option<String?>? errorOption,
    bool? validating,
  }) {
    return NameEditState(
      nameOption: nameOption ?? this.nameOption,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
    );
  }

  final Option<String> nameOption;
  final Option<String?> errorOption;
  final bool validating;

  String get nameOrEmpty => nameOption.getOrElse(() => '');

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
  List<Object?> get props => [nameOption, errorOption, validating];
}
