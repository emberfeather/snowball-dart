library test.amortization_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

main() {
  test('Simple values', () {
    var debt = new Debt('Test1', 100.0, .1, 25.0);
    var amortized = new Amortization(debt);
    expect(amortized.debt, debt);
  });

  group('Simple debt', () {
    test('Single payment', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      amortized.addPayment(25);
      expect(amortized.payments.length, 1);
      expect(amortized.payments[0].interest, 0.83);
      expect(amortized.payments[0].principal, 24.17);
    });

    test('Zero', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      amortized.addPayment(0);
      expect(amortized.payments.length, 1);
    });

    test('Non-payment', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      expect(() { amortized.addPayment(-1); }, throwsException);
    });

    test('Amortize payments', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      amortized.amortize(25);
      expect(amortized.payments.length, 5);
      expect(amortized.payments[4].interest, 0.02);
      expect(amortized.payments[4].principal, 2.11);
    });

    test('Varied payments', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      amortized.addPayment(5);
      expect(amortized.payments.length, 1);
      expect(amortized.payments[0].interest, 0.83);
      expect(amortized.payments[0].principal, 4.17);
      amortized.addPayment(10);
      expect(amortized.payments.length, 2);
      expect(amortized.payments[1].interest, 0.80);
      expect(amortized.payments[1].principal, 9.20);
      amortized.addPayment(15);
      expect(amortized.payments.length, 3);
      expect(amortized.payments[2].interest, 0.72);
      expect(amortized.payments[2].principal, 14.28);
      amortized.addPayment(20);
      expect(amortized.payments.length, 4);
      expect(amortized.payments[3].interest, 0.60);
      expect(amortized.payments[3].principal, 19.40);
      amortized.addPayment(25);
      expect(amortized.payments.length, 5);
      expect(amortized.payments[4].interest, 0.44);
      expect(amortized.payments[4].principal, 24.56);
      amortized.addPayment(30);
      expect(amortized.payments.length, 6);
      expect(amortized.payments[5].interest, 0.24);
      expect(amortized.payments[5].principal, 28.39);
    });

    test('Payoff', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payoff, 100.83);
      amortized.addPayment(25);
      expect(amortized.payoff, 76.46);
    });
  });
}