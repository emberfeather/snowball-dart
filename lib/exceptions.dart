part of snowball;

class SnowballException implements Exception {
  String message;
  SnowballException(this.message);

  String toString() => 'Snowball: $message';
}

class BalanceException extends SnowballException {
  BalanceException(String msg) : super(msg);
}

class LabelException extends SnowballException {
  LabelException(String msg) : super(msg);
}

class MinPaymentException extends SnowballException {
  MinPaymentException(String msg) : super(msg);
}

class PaymentException extends SnowballException {
  PaymentException(String msg) : super(msg);
}

class RateException extends SnowballException {
  RateException(String msg) : super(msg);
}
