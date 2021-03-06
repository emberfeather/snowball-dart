library test.schedule_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

var schedules;
var debts;

void setup() {
  // Map of debt arrays for different test situations.
  debts = {
    'eqBalanceEqRateEqMinimum': [
      new Debt('Test1', 200.0, 0.1, 10.0),
      new Debt('Test2', 200.0, 0.1, 10.0),
      new Debt('Test3', 200.0, 0.1, 10.0),
      new Debt('Test4', 200.0, 0.1, 10.0)
    ],
    'eqBalanceEqRateEqMinimumInterestOnly': [
      new Debt('Test1', 200.0, 0.1, 1.67),
      new Debt('Test2', 200.0, 0.1, 1.67),
      new Debt('Test3', 200.0, 0.1, 1.67),
      new Debt('Test4', 200.0, 0.1, 1.67)
    ]
  };
}

main() {
  group('Schedules', () {
    test('Insufficient payment', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimum']);
      expect(() { schedule.schedulePayment(20); }, throwsException);
    });

    test('Minimum payment', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimum']);
      var remainingPayment = schedule.schedulePayment(40);
      expect(remainingPayment, 1.24);

      // Check to make sure that the debts were paid off at the correct payment with the correct amount.
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][0]].payments[21].total, 9.69);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][1]].payments[21].total, 9.69);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][2]].payments[21].total, 9.69);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][3]].payments[21].total, 9.69);
    });

    test('Extra payment', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimum']);
      var remainingPayment = schedule.schedulePayment(50);
      expect(remainingPayment, 37.76);

      // Check to make sure that the debts were paid off at the correct payment with the correct amount.
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][0]].payments[10].total, 9.71);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][1]].payments[14].total, 5.81);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][2]].payments[16].total, 3.65);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][3]].payments[17].total, 12.24);
    });

    test('Interest only payment', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimumInterestOnly']);
      var remainingPayment = schedule.schedulePayment(6.68);
      expect(schedule.isInterestOnly, true);
      expect(remainingPayment, 0);

      // Check to make sure that the debts have at least one payment.
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][0]].payments[0].total, 1.67);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][1]].payments[0].total, 1.67);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][2]].payments[0].total, 1.67);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][3]].payments[0].total, 1.67);

      // Show that the processing correctly stops when it is doing interest only repayment.
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][0]].payments.length, 1);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][1]].payments.length, 1);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][2]].payments.length, 1);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimumInterestOnly'][3]].payments.length, 1);
    });

    // When paying off multiple in a single payment it should keep applying extra funds until there are no unpaid debts.
    test('Payoff multiple debts in single payment', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimum']);
      var remainingPayment = schedule.schedulePayment(450);
      expect(remainingPayment, 90.34);

      // Check to make sure that the debts were paid off at the correct payment with the correct amount.
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][0]].payments[0].total, 201.67);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][1]].payments[0].total, 201.67);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][2]].payments[1].total, 166.39);
      expect(schedule.schedule[debts['eqBalanceEqRateEqMinimum'][3]].payments[1].total, 193.27);
    });

    test('Principal, interest, and total', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimum']);
      var remainingPayment = schedule.schedulePayment(50);
      expect(remainingPayment, 37.76);

      // Check to make sure that the debt principal, interest, and totals all match up.
      expect(schedule.principal, 800.00);
      expect(schedule.interest, 62.24);
      expect(schedule.total, 862.24);
    });

    test('Year and month calculation', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimum']);
      var remainingPayment = schedule.schedulePayment(50);

      // Based on the number of payments, the number of years and months should be calculated.
      expect(schedule.length, 18);
      expect(schedule.years, 1);
      expect(schedule.months, 6);
    });

    test('Year and month calculation, infinite', () {
      setup();
      var schedule = new Schedule(LOWESTBALANCEFIRST, debts['eqBalanceEqRateEqMinimumInterestOnly']);
      var remainingPayment = schedule.schedulePayment(6.68);
      expect(schedule.isInterestOnly, true);
      expect(remainingPayment, 0);

      // Based on the number of payments, the number of years and months should be calculated.
      expect(schedule.length, double.INFINITY);
      expect(schedule.years, double.INFINITY);
      expect(schedule.months, double.INFINITY);
    });
  });
}