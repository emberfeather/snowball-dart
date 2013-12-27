library test.debt_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/debt.dart';

var debt1;

void setup() {
  debt1 = new Debt('Test1', 2500.0, .1, 25.0);
}

void main() {
  test('Initial values', () {
    setup();
    expect(debt1.label, 'Test1');
    expect(debt1.balance, 2500);
    expect(debt1.rate, .1);
    expect(debt1.minPayment, 25);
  });
  
  group('Label', () {
    test('Reassignment', () {
      setup();
      expect(debt1.label, 'Test1');
      debt1.label = 'Test1.0';
      expect(debt1.label, 'Test1.0');
    });
    
    test('Blank', () {
      setup();
      expect(debt1.label, 'Test1');
      expect(() { debt1.label = ''; }, throwsException);
    });
  });
  
  group('Balance', () {
    test('Reassignment', () {
      setup();
      expect(debt1.balance, 2500);
      debt1.balance = 1000;
      expect(debt1.balance, 1000);
    });
    
    test('Negative', () {
      setup();
      expect(() { debt1.balance = -1; }, throwsException);
    });
  });
  
  group('Rate', () {
    test('Reassignment', () {
      setup();
      expect(debt1.rate, .1);
      debt1.rate = .23;
      expect(debt1.rate, .23);
    });
    
    test('Negative', () {
      setup();
      expect(() { debt1.rate = -.1; }, throwsException);
    });
    
    test('Too large', () {
      setup();
      expect(() { debt1.rate = 3.1; }, throwsException);
    });
  });
  
  group('Min payment', () {
    test('Reassignment', () {
      setup();
      expect(debt1.minPayment, 25);
      debt1.minPayment = 135;
      expect(debt1.minPayment, 135);
    });
    
    test('Negative', () {
      setup();
      expect(() { debt1.minPayment = -.1; }, throwsException);
    });
    
    test('Zero', () {
      setup();
      debt1.minPayment = 0;
      expect(debt1.minPayment, 0);
    });
  });
}
