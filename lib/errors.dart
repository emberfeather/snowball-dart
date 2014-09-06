part of snowball;

class SnowballException implements Exception {
  String message;
  SnowballException(this.message);

  String toString() => 'Snowball: $message';
}

class PaymentException extends SnowballException {
  PaymentException(String msg) : super(msg);
}
