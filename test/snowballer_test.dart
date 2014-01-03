library test.snowballer_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

var debts;

void setup() {
  // Map of debt arrays for different test situations.
  debts = {
    'eqBalanceAscRateEqMinimum': [
      new Debt('Test1', 2500.0, .11, 25.0),
      new Debt('Test2', 2500.0, .12, 25.0),
      new Debt('Test3', 2500.0, .13, 25.0),
      new Debt('Test4', 2500.0, .14, 25.0)
    ]
  };
}

main() {
  test('Simple values', () {
    setup();
    var snowballer = new Snowballer(debts['eqBalanceAscRateEqMinimum']);
    expect(snowballer.debts, debts['eqBalanceAscRateEqMinimum']);
    expect(snowballer.methods, snowballer.availableMethods);
  });

  group('Methods', () {
    test('Initialization', () {
      setup();
      var snowballer = new Snowballer(debts['eqBalanceAscRateEqMinimum'], [HIGHESTBALANCEFIRST]);
      expect(snowballer.methods, [HIGHESTBALANCEFIRST]);
    });

    test('Reassignment', () {
      setup();
      var snowballer = new Snowballer(debts['eqBalanceAscRateEqMinimum']);
      expect(snowballer.methods, snowballer.availableMethods);
      snowballer.methods = [HIGHESTBALANCEFIRST];
      expect(snowballer.methods, [HIGHESTBALANCEFIRST]);
    });

    test('Invalid method', () {
      setup();
      var snowballer = new Snowballer(debts['eqBalanceAscRateEqMinimum']);
      expect(snowballer.methods, snowballer.availableMethods);
      expect(() { snowballer.methods = ['nonexistantMethod']; }, throwsException);
    });
  });
}