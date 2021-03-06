part of snowball;

/**
 * Debt class for describing and working with specific debt information.
 */
class Debt {
  var _label;
  num _balance;
  num _rate;
  num _minPayment;

  Debt(String label, num balance, num rate, num minPayment) {
    this.label = label;
    this.balance = balance;
    this.rate = rate;
    this.minPayment = minPayment;
  }

  num get balance => _balance;
  set balance(num value) {
    if (value.isNegative) {
      throw new BalanceException('Balance cannot be negative');
    }
    _balance = value;
  }

  get label => _label;
  set label(var value) {
    if (value.isEmpty) {
      throw new LabelException('Label cannot be empty');
    }
    _label = value;
  }

  num get minPayment => _minPayment;
  set minPayment(num value) {
    if (value.isNegative) {
      throw new MinPaymentException('Minimum payment cannot be negative');
    }

    var interestAmount = this.balance * (this.rate / 12);
    interestAmount = double.parse(interestAmount.toStringAsFixed(2));
    if (value < interestAmount) {
      interestAmount = interestAmount.toStringAsFixed(2);
      throw new MinPaymentException('Minimum payment needs to be at least $interestAmount');
    }

    _minPayment = value;
  }

  num get percent => _rate * 100;
  set percent(num value) {
    this.rate = value / 100;
  }

  num get rate => _rate;
  set rate(num value) {
    if (value.isNegative) {
      throw new RateException('Rate cannot be negative');
    }
    if (value > 3) {
      throw new RateException('Rate cannot be over 300%');
    }
    _rate = value;
  }

  String toString() => '$label ( $balance @ $rate w/ $minPayment )';
}
