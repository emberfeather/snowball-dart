library test.schedule_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

var schedules;
var debts;

void setup() {
  // Map of debt arrays for different test situations.
  debts = {
    'eqBalanceAscRateEqMinimum': [
      new Debt('Test1', 100.0, .11, 10.0),
      new Debt('Test2', 100.0, .12, 10.0),
      new Debt('Test3', 100.0, .13, 10.0),
      new Debt('Test4', 100.0, .14, 10.0)
    ]
  };
}

main() {
  test('Simple values', () {
    setup();
    var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceAscRateEqMinimum']);
    expect(schedule.method, LOWESTBALANCEFIRST);
    expect(schedule.debts, debts['eqBalanceAscRateEqMinimum']);
  });
}