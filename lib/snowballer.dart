part of snowball;

/**
 * Main snowballing logic for computing the snowballed schedules across multiple debts.
 */
class Snowballer {
  List<String> _methods = [
    BALANCEPAYMENTRATIO,
    BALANCERATERATIO,
    HIGHESTBALANCEFIRST,
    HIGHESTRATEFIRST ,
    LOWESTBALANCEFIRST,
    LOWESTRATEFIRST
  ];

  Snowballer([List<String> methods]) {
    if (methods != null) {
      this.methods = methods;
    }
  }

  List<String> get methods => _methods;
  set methods(List<String> value) {
    if (value == null) {
      throw new Exception('Snowballing methods cannot be null');
    }

    if (value.length == 0) {
      throw new Exception('Need to specify at least one method for snowballing');
    }

    _methods = value;
  }

  /**
   * Generate the snowball schedules for all the methods with a given the payment.
   */
  Map snowball(List<Debt> debts, num payment) {
    var schedules = {};

    for (var method in this.methods) {
      schedules[method] = new Schedule(method, debts);
      schedules[method].schedulePayment(payment);
    }

    return schedules;
  }
}
