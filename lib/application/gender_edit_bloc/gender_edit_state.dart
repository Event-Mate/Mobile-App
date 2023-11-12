part of 'gender_edit_bloc.dart';

class GenderEditState extends Equatable {
  const GenderEditState({
    required this.genderOption,
    required this.validating,
    required this.errorOption,
  });

  factory GenderEditState.initial() {
    return GenderEditState(
      genderOption: none(),
      errorOption: none(),
      validating: false,
    );
  }

  final Option<GenderType> genderOption;
  final Option<String?> errorOption;
  final bool validating;

  GenderEditState copyWith({
    Option<GenderType>? genderOption,
    Option<String?>? errorOption,
    bool? validating,
  }) {
    return GenderEditState(
      genderOption: genderOption ?? this.genderOption,
      errorOption: errorOption ?? this.errorOption,
      validating: validating ?? this.validating,
    );
  }

  GenderType? get genderOrNull => genderOption.fold(() => null, id);

  bool get isFormValid => errorOption.fold(
        () {
          return false;
        },
        (errorMessage) {
          if (errorMessage != null) {
            return false;
          } else {
            return true;
          }
        },
      );

  String? get errorText => errorOption.fold(() => null, id);
  @override
  List<Object> get props => [genderOption, errorOption, validating];

  @override
  bool? get stringify => true;
}
