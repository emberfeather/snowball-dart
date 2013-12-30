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
      throw new Exception('Balance cannot be negative');
    }
    _balance = value;
  }
  
  get label => _label;
  set label(var value) {
    if (value.isEmpty) {
      throw new Exception('Label cannot be empty');
    }
    _label = value;
  }
  
  num get minPayment => _minPayment;
  set minPayment(num value) {
    if (value.isNegative) {
      throw new Exception('Minimum payment cannot be negative');
    }
    _minPayment = value;
  }
  
  num get rate => _rate;
  set rate(num value) {
    if (value.isNegative) {
      throw new Exception('Rate cannot be negative');
    }
    if (value > 3) {
      throw new Exception('Rate cannot be over 3');
    }
    _rate = value;
  }
  
  String toString() => '$label ( $balance @ $rate w/ $minPayment )';
}
