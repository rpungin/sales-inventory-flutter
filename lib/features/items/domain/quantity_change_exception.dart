enum QuantityChangeErrorCode { incrementError, decrementError }

class QuantityChangeException implements Exception {
  final QuantityChangeErrorCode errorCode;
  final String message;
  const QuantityChangeException(
      {required this.errorCode, required this.message});
}
