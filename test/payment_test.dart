library test.payment_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

main() {
  test('Simple values', () {
    var payment = new Payment(25.0, 5.0);
    expect(payment.principal, 25.0);
    expect(payment.interest, 5.0);
    expect(payment.total, 30.0);
  });

  test('Optional interest', () {
    var payment = new Payment(25.0);
    expect(payment.principal, 25.0);
    expect(payment.interest, 0.0);
    expect(payment.total, 25.0);
  });
}