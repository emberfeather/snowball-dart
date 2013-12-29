library test.schedule_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

var schedules;
var debts;

void setup() {
  schedules = {
    'lowBalance': new Schedule('Lowest Balance First')
  };
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
    expect(schedules['lowBalance'].label, 'Lowest Balance First');
  });
  
  group('Label', () {
    test('Reassignment', () {
      setup();
      expect(schedules['lowBalance'].label, 'Lowest Balance First');
      schedules['lowBalance'].label = 'Test1.0';
      expect(schedules['lowBalance'].label, 'Test1.0');
    });
    
    test('Blank', () {
      setup();
      expect(schedules['lowBalance'].label, 'Lowest Balance First');
      expect(() { schedules['lowBalance'].label = ''; }, throwsException);
    });
  });

  group('Debts', () {
    test('Reassignment', () {
      setup();
      expect(schedules['lowBalance'].debts, []);
      schedules['lowBalance'].debts = debts['eqBalanceAscRateEqMinimum'];
      expect(schedules['lowBalance'].debts, debts['eqBalanceAscRateEqMinimum']);
    });
    
    test('Null', () {
      setup();
      expect(schedules['lowBalance'].debts, []);
      expect(() { schedules['lowBalance'].debts = null; }, throwsException);
    });
  });
}