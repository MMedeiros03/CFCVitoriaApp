class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class InvalidTokenException implements Exception {
  final String message;
  InvalidTokenException(this.message);
}

class BusinessException implements Exception {
  final String message;
  BusinessException(this.message);
}
