library test.debt_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/debt.dart';

var debt1;

void setup() {
  debt1 = new Debt('Test1', 2500, .1, 25);
}

main() {
  test('simple values', () {
    setup();
    expect(debt1.label, 'Test1');
    expect(debt1.balance, 2500);
    expect(debt1.rate, .1);
    expect(debt1.minPayment, 25);
  });
}