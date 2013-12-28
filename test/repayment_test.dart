library test.repayment_test;

import 'package:unittest/unittest.dart';
import 'package:snowball/snowball.dart';

main() {
  group('Highest Balance First', () {
    test('Sort order', () {
      Repayment repayment = new Repayment(HIGHESTBALANCEFIRST);
      List<Debt> debts = [
        new Debt('Test1', 1500.0, .1, 25.0),
        new Debt('Test4', 500.0, .1, 25.0),
        new Debt('Test3', 3500.0, .1, 25.0),
        new Debt('Test2', 2500.0, .1, 25.0),
       ];
      List<Debt> sorted = repayment.sort(debts);
      
      // Assert that the debts have been correctly reordered.
      expect(sorted[0], debts[2]);
      expect(sorted[1], debts[3]);
      expect(sorted[2], debts[0]);
      expect(sorted[3], debts[1]);
    });
    
    test('Allow caching', () {
      Repayment repayment = new Repayment(HIGHESTBALANCEFIRST);
      expect(true, repayment.method.allowCaching);
    });
  });
  
  group('Highest Rate First', () {
    test('Sort order', () {
      Repayment repayment = new Repayment(HIGHESTRATEFIRST);
      List<Debt> debts = [
                          new Debt('Test1', 500.0, .12, 25.0),
                          new Debt('Test4', 500.0, .11, 25.0),
                          new Debt('Test3', 500.0, .14, 25.0),
                          new Debt('Test2', 500.0, .13, 25.0),
                          ];
      List<Debt> sorted = repayment.sort(debts);
      
      // Assert that the debts have been correctly reordered.
      expect(sorted[0], debts[2]);
      expect(sorted[1], debts[3]);
      expect(sorted[2], debts[0]);
      expect(sorted[3], debts[1]);
    });
    
    test('Allow caching', () {
      Repayment repayment = new Repayment(HIGHESTRATEFIRST);
      expect(true, repayment.method.allowCaching);
    });
  });
  
  group('Lowest Balance First', () {
    test('Sort order', () {
      Repayment repayment = new Repayment(LOWESTBALANCEFIRST);
      List<Debt> debts = [
        new Debt('Test1', 1500.0, .1, 25.0),
        new Debt('Test4', 500.0, .1, 25.0),
        new Debt('Test3', 3500.0, .1, 25.0),
        new Debt('Test2', 2500.0, .1, 25.0),
       ];
      List<Debt> sorted = repayment.sort(debts);
      
      // Assert that the debts have been correctly reordered.
      expect(sorted[0], debts[1]);
      expect(sorted[1], debts[0]);
      expect(sorted[2], debts[3]);
      expect(sorted[3], debts[2]);
    });
    
    test('Allow caching', () {
      Repayment repayment = new Repayment(LOWESTBALANCEFIRST);
      expect(true, repayment.method.allowCaching);
    });
  });
  
  group('Lowest Rate First', () {
    test('Sort order', () {
      Repayment repayment = new Repayment(LOWESTRATEFIRST);
      List<Debt> debts = [
                          new Debt('Test1', 500.0, .13, 25.0),
                          new Debt('Test4', 500.0, .11, 25.0),
                          new Debt('Test3', 500.0, .14, 25.0),
                          new Debt('Test2', 500.0, .12, 25.0),
                          ];
      List<Debt> sorted = repayment.sort(debts);
      
      // Assert that the debts have been correctly reordered.
      expect(sorted[0], debts[1]);
      expect(sorted[1], debts[3]);
      expect(sorted[2], debts[0]);
      expect(sorted[3], debts[2]);
    });
    
    test('Allow caching', () {
      Repayment repayment = new Repayment(LOWESTRATEFIRST);
      expect(true, repayment.method.allowCaching);
    });
  });
}
