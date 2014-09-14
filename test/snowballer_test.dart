library test.snowballer_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

var debts;

void setup() {
  // Map of debt arrays for different test situations.
  debts = {
    'eqBalanceAscRateEqMinimum': [
      new Debt('Test1', 2500.0, .11, 40.0),
      new Debt('Test2', 2500.0, .12, 40.0),
      new Debt('Test3', 2500.0, .13, 40.0),
      new Debt('Test4', 2500.0, .14, 40.0)
    ]
  };
}

main() {
  group('Methods', () {
    test('Initialization', () {
      var snowballer = new Snowballer([HIGHESTBALANCEFIRST]);
      expect(snowballer.methods, [HIGHESTBALANCEFIRST]);
    });
  });

  group('Simple snowballing', () {
    test('Highest Balance First', () {
      setup();
      var snowballer = new Snowballer([HIGHESTBALANCEFIRST]);
    });
  });
}