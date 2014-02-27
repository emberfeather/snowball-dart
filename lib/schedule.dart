part of snowball;

/**
 * Schedule of debt repayment.
 */
class Schedule {
  String _method;
  List<Debt> _debts = [];
  Map _schedule = {};
  Method _repaymentMethod;

  Schedule(String method, List<Debt> debts) {
    _method = method;
    _debts = debts;
    _repaymentMethod = new Repayment(method).method;

    // Initialize an empty amortization for each debt in the schedule.
    for (var debt in debts) {
      _schedule[debt] = new Amortization(debt);
    }
  }

  /**
   * Determine if all of the debts not paid are in interest only repayment.
   */
  bool get isInterestOnly {
    if (isPaid) {
      return false;
    }

    for (var debt in _debts) {
      if (!_schedule[debt].isPaid && !_schedule[debt].isInterestOnly) {
        return false;
      }
    }

    return true;
  }

  /**
   * Determine if the all debts has been paid off with the amortization.
   */
  bool get isPaid {
    for (var debt in _debts) {
      if (!_schedule[debt].isPaid) {
        return false;
      }
    }

    return true;
  }

  String get method => _method;
  List<Debt> get debts => _debts;
  Map get schedule => _schedule;

  /**
   * Distributes a single payment across unpaid debts.
   */
  num addPayment(num payment) {
    num remainingPayment = payment;
    List<Debt> repaymentOrder = _repaymentMethod.sort(debts);
    List currentPayment = new List.filled(repaymentOrder.length, 0);
    num extraPayment;

    // Make all the minimum payments.
    for (var i = 0; i < repaymentOrder.length; i++) {
      if (!_schedule[repaymentOrder[i]].isPaid) {
        // Pay at least the payoff, at most the minimum payment.
        currentPayment[i] = double.parse(
            math.min(repaymentOrder[i].minPayment, _schedule[repaymentOrder[i]].payoff).toStringAsFixed(2));
        remainingPayment -= currentPayment[i];
      }
    }

    // Distribute unused payment.
    for (var i = 0; i < repaymentOrder.length; i++) {
      if (remainingPayment > 0 && !_schedule[repaymentOrder[i]].isPaid
          && _schedule[repaymentOrder[i]].payoff > repaymentOrder[i].minPayment) {
        // Pay off in the repayment order.
        extraPayment = math.min(_schedule[repaymentOrder[i]].payoff - repaymentOrder[i].minPayment, remainingPayment);
        currentPayment[i] += extraPayment;
        remainingPayment -= extraPayment;
      }
    }

    // Commit the actual payments.
    for (var i = 0; i < repaymentOrder.length; i++) {
      if (!_schedule[repaymentOrder[i]].isPaid) {
        _schedule[repaymentOrder[i]].addPayment(currentPayment[i]);
      }
    }

    // Return unused payment.
    return double.parse(remainingPayment.toStringAsFixed(2));
  }

  /**
   * Uses the payment to completely amortize and schedule all debts for repayment.
   */
  num schedulePayment(num payment) {
    // Ensure minimum payments are met.
    var minimumPayments = 0;
    for (var debt in _debts) {
      if (!_schedule[debt].isPaid) {
        minimumPayments += debt.minPayment;
      }
    }
    if (payment < minimumPayments) {
      throw new Exception('Not enough payment to pay minimum payments.');
    }

    // Keep adding payments until all the debts are paid.
    var remainingPayment;

    while (!isPaid && !isInterestOnly) {
      remainingPayment = addPayment(payment);
    }

    return remainingPayment;
  }
}
