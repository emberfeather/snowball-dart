part of snowball;

/**
 * Amortization of debt repayment.
 */
class Amortization {
  Debt _debt;
  num _balance;
  List<Payment> _payments = [];
  int _paymentsPerYear = 12;
  bool _isInterestOnly = false;

  Amortization(Debt debt) {
    _debt = debt;
    _balance = debt.balance;
  }

  num get balance => _balance;

  /**
   * Debt is non-mutable, recreate amortization for each debt or change to debt.
   */
  Debt get debt => _debt;

  /**
   * Sum of all interest paid so far.
   */
  num get interest {
    // Interest only is infinite interest.
    if( this.isInterestOnly ) {
      return double.INFINITY;
    }

    num paidInterest = 0.0;

    for (var payment in _payments) {
      paidInterest += payment.interest;
    }

    return double.parse(paidInterest.toStringAsFixed(2));
  }

  /**
   * Amortization is infinite if not paying more than interest.
   */
  bool get isInterestOnly => _isInterestOnly;

  /**
   * Determine if the debt has been paid off with the amortization.
   */
  bool get isPaid => balance <= 0;

  /**
   * Calculate the number of payments so far.
   */
  int get length => _payments.length;

  List<Payment> get payments => _payments;

  /**
   * Calculate the remaining balance and interest to payoff.
   */
  num get payoff {
    return double.parse((_unpaidInterest() + _balance).toStringAsFixed(2));
  }

  /**
   * Sum of all principal paid so far.
   */
  num get principal {
    num paidPricipal = 0.0;

    for (var payment in _payments) {
      paidPricipal += payment.principal;
    }

    return double.parse(paidPricipal.toStringAsFixed(2));
  }

  /**
   * Sum all interest and payments made.
   */
  num get total {
    return double.parse((this.interest + this.principal).toStringAsFixed(2));
  }

  /**
   * Completely amortize based on payment amount or minimum payment.
   */
  void amortize([num amount]) {
    if(amount == null) {
      amount = _debt.minPayment;
    }

    while(_balance > 0 && !isInterestOnly) {
      addPayment(amount);
    }
  }

  /**
   * Add a payment amount to the amortization and return any remaining amount.
   */
  num addPayment([num amount]) {
    // Only need to add a payment when there is something to pay down.
    if(_balance <= 0) {
      return amount;
    }

    if(amount == null) {
      amount = _debt.minPayment;
    }

    // Cannot have an empty payment.
    if(amount < 0) {
      throw new Exception('Payment amount must be a positive number.');
    }

    num interest = _unpaidInterest();
    num principal = double.parse((math.min(amount - interest, _balance)).toStringAsFixed(2));

    // Determine if only paying on the interest.
    _isInterestOnly = principal <= 0;

    Payment payment = new Payment(principal, interest);
    _payments.add(payment);

    // Update the balance to reflect the payment.
    _balance -= payment.principal;

    // Return any leftover amount.
    return amount - payment.total;
  }

  /**
   * Determines the interest for the next payment.
   */
  num _unpaidInterest() {
    return double.parse(((_debt.rate / _paymentsPerYear) * _balance).toStringAsFixed(2));
  }
}
