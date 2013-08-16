library test.debt_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/debt.dart';

var debt1;

void setup() {
  debt1 = new Debt('Test1', 2500, .1, 25);
}

main() {
  test('initial values', () {
    setup();
    expect(debt1.label, 'Test1');
    expect(debt1.balance, 2500);
    expect(debt1.rate, .1);
    expect(debt1.minPayment, 25);
  });
  
  group('label', () {
    test('reassignment', () {
      setup();
      expect(debt1.label, 'Test1');
      debt1.label = 'Test1.0';
      expect(debt1.label, 'Test1.0');
    });
    
    test('blank', () {
      setup();
      expect(debt1.label, 'Test1');
      expect(() { debt1.label = ''; }, throwsException);
    });
  });
  
  group('balance', () {
    test('reassignment', () {
      setup();
      expect(debt1.balance, 2500);
      debt1.balance = 1000;
      expect(debt1.balance, 1000);
    });
    
    test('negative', () {
      setup();
      expect(() { debt1.balance = -1; }, throwsException);
    });
  });
  
  group('rate', () {
    test('reassignment', () {
      setup();
      expect(debt1.rate, .1);
      debt1.rate = .23;
      expect(debt1.rate, .23);
    });
    
    test('negative', () {
      setup();
      expect(() { debt1.rate = -.1; }, throwsException);
    });
    
    test('too large', () {
      setup();
      expect(() { debt1.rate = 3.1; }, throwsException);
    });
  });
  
  group('min payment', () {
    test('reassignment', () {
      setup();
      expect(debt1.minPayment, 25);
      debt1.minPayment = 135;
      expect(debt1.minPayment, 135);
    });
    
    test('negative', () {
      setup();
      expect(() { debt1.minPayment = -.1; }, throwsException);
    });
    
    test('zero', () {
      setup();
      debt1.minPayment = 0;
      expect(debt1.minPayment, 0);
    });
  });
}
