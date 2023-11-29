enum GenderType {
  MAN('man'),
  WOMAN('woman'),
  OTHER('other'),
  NONE('none');

  const GenderType(this.value);

  factory GenderType.fromValue(String value) {
    switch (value) {
      case 'man':
        return GenderType.MAN;
      case 'woman':
        return GenderType.WOMAN;
      case 'other':
        return GenderType.OTHER;
      default:
        return GenderType.NONE;
    }
  }
  final String value;
}
