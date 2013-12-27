library schedule;
import 'package:snowball/debt.dart';

/**
 * Schedule of debt repayment.
 */
class Schedule {
  var _label;
  List<Debt> _debts = [];
  
  Schedule(String label, [List<Debt> debts]) {
    this.label = label;
    if(debts != null) {
      this.debts = debts;
    }
  }
  
  get label => _label;
  set label(var value) {
    if (value.isEmpty) {
      throw new Exception('Label cannot be empty');
    }
    _label = value;
  }
  
  get debts => _debts;
  set debts(List<Debt> value) {
    if (value == null) {
      throw new Exception('Debts cannot be null');
    }
    _debts = value;
  }
}
