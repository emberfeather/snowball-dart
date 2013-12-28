import 'amortization_test.dart' as amortization_test;
import 'debt_test.dart' as debt_test;
import 'payment_test.dart' as payment_test;
import 'repayment_test.dart' as repayment_test;
import 'schedule_test.dart' as schedule_test;

main() {
  debt_test.main();
  payment_test.main();
  amortization_test.main();
  repayment_test.main();
  schedule_test.main();
}
