class InternalServerError implements Exception {
  InternalServerError(this.message);

  final String message;

  @override
  String toString() => message;
}

enum ClientExceptionType {
  badRequestException,
  unauthorizedException,
  forbiddenException,
  notFoundException,
  timoutException,
  undefined,
}

class ClientException implements Exception {
  ClientException(this.type, this.message);

  final ClientExceptionType type;
  final String message;

  @override
  String toString() => message;
}
