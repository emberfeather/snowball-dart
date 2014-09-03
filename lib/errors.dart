part of snowball;

class SnowballException implements Exception {
  String cause;
  SnowballException(this.cause);

  String toString() => 'Snowball: $cause';
}

class PaymentException extends SnowballException {
  PaymentException(String msg) : super(msg);
}
