library debt;

/**
 * Debt class for describing and working with specific debt information.
 */
class Debt {
  var _label;
  double _balance;
  double _rate;
  double _minPayment;
  
  Debt(String label, double balance, double rate, double minPayment) {
    this.label = label;
    this.balance = balance;
    this.rate = rate;
    this.minPayment = minPayment;
  }
  
  get balance => _balance;
  set balance(double value) {
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
  
  get minPayment => _minPayment;
  set minPayment(double value) {
    if (value.isNegative) {
      throw new Exception('Minimum payment cannot be negative');
    }
    _minPayment = value;
  }
  
  get rate => _rate;
  set rate(double value) {
    if (value.isNegative) {
      throw new Exception('Rate cannot be negative');
    }
    if (value > 3) {
      throw new Exception('Rate cannot be over 3');
    }
    _rate = value;
  }
}
