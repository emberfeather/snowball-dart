library test.schedule_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/amortization.dart';
import 'package:snowball/debt.dart';

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
      amortized.addPayment();
      expect(amortized.payments.length, 1);
      expect(amortized.payments[0].interest, 0.83);
      expect(amortized.payments[0].principal, 24.17);
    });
    
    test('Non-payment', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      expect(() { amortized.addPayment(0); }, throwsException);
    });
    
    test('Amortize payments', () {
      var debt = new Debt('Test1', 100.0, .1, 25.0);
      var amortized = new Amortization(debt);
      expect(amortized.payments.length, 0);
      amortized.amortize();
      expect(amortized.payments.length, 5);
      expect(amortized.payments[4].interest, 0.02);
      expect(amortized.payments[4].principal, 2.11);
    });
  });
}