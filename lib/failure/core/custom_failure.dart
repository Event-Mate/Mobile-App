abstract class CustomFailure {
  const CustomFailure();
}

/// 403 - Forbidden
abstract class ForbiddenCustomFailure extends CustomFailure {
  const ForbiddenCustomFailure();
  String? get message;
}

/// 404 - Not Found
abstract class NotFoundCustomFailure extends CustomFailure {
  const NotFoundCustomFailure();
  String? get message;
}

/// 401 - Unauthorized
abstract class UnauthorizedCustomFailure extends CustomFailure {
  const UnauthorizedCustomFailure();
  String? get message;
}

/// 403 - Forbidden
abstract class ConflictCustomFailure extends CustomFailure {
  const ConflictCustomFailure();
  String? get message;
}

/// 400 - Bad Request
abstract class BadRequestCustomFailure extends CustomFailure {
  const BadRequestCustomFailure();
  String? get message;
}

/// 500 - Internal Server Error
abstract class UnknownCustomFailure extends CustomFailure {
  const UnknownCustomFailure();
  String? get message;
}
