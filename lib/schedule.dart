part of snowball;

/**
 * Schedule of debt repayment.
 */
class Schedule {
  var _method;
  List<Debt> _debts = [];

  Schedule(String method, List<Debt> debts) {
    _method = method;
    _debts = debts;
  }

  String get method => _method;
  List<Debt> get debts => _debts;

  /**
   * Adds a single payment to the schedule.
   */
  num addPayment(num payment) {

  }

  /**
   * Uses the payment to completely amortize and schedule all debts for repayment.
   */
  void schedule(num payment) {

  }
}
