part of snowball;

/**
 * Main snowballing logic for computing the snowballed schedules across multiple debts.
 */
class Snowballer {
  List<String> _availableMethods = [
    BALANCEPAYMENTRATIO,
    BALANCERATERATIO,
    HIGHESTBALANCEFIRST,
    HIGHESTRATEFIRST ,
    LOWESTBALANCEFIRST,
    LOWESTRATEFIRST
  ];
  List<String> _methods = [];
  List<Debt> _debts = [];

  Snowballer(List<Debt> debts, [List<String> methods]) {
    this.debts = debts;
    if (methods != null) {
      this.methods = methods;
    } else {
      this.methods = _availableMethods;
    }
  }

  List<Debt> get debts => _debts;
  set debts(List<Debt> value) {
    if (value == null) {
      throw new Exception('Debts cannot be null');
    }
    _debts = value;
  }

  List<String> get availableMethods => _availableMethods;

  List<String> get methods => _methods;
  set methods(List<String> value) {
    if (value == null) {
      throw new Exception('Snowballing methods cannot be null');
    }

    if (value.length == 0) {
      throw new Exception('Need to specify at least one method for snowballing');
    }

    for (var item in value) {
      if (!_availableMethods.contains(item)) {
        throw new Exception('$item is not a valid snowballing method');
      }
    }

    _methods = value;
  }
}
