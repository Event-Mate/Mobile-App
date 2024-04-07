//! Be careful while changing the order of the enum, it is used in the registration flow.
enum RegistrationStepType {
  NAME('name'),
  USERNAME('username'),
  EMAIL('email'),
  PASSWORD('password'),
  GENDER('gender'),
  DATE_OF_BIRTH('date_of_birth'),
  INTERESTS('interests'),
  AVATAR_URL('avatar_url');

  const RegistrationStepType(this.value);
  final String value;
}
