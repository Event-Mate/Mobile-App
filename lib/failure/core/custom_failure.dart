abstract class CustomFailure {
  const CustomFailure();
}

/// 403 - Forbidden
class ForbiddenCustomFailure extends CustomFailure {
  const ForbiddenCustomFailure(this.message);
  final String message;
}

/// 404 - Not Found
class NotFoundCustomFailure extends CustomFailure {
  const NotFoundCustomFailure(this.message);
  final String message;
}

/// 401 - Unauthorized
class UnauthorizedCustomFailure extends CustomFailure {
  const UnauthorizedCustomFailure(this.message);
  final String message;
}

/// 403 - Forbidden
class ConflictCustomFailure extends CustomFailure {
  const ConflictCustomFailure(this.message);
  final String message;
}

/// 400 - Bad Request
class BadRequestCustomFailure extends CustomFailure {
  const BadRequestCustomFailure(this.message);
  final String message;
}

/// 500 - Internal Server Error
class UnknownCustomFailure extends CustomFailure {
  const UnknownCustomFailure(this.message);
  final String message;
}
