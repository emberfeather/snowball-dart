library snowball;

import 'dart:math' as math;

part 'amortization.dart';
part 'debt.dart';
part 'payment.dart';
part 'repayment.dart';
part 'schedule.dart';
part 'snowballer.dart';

/**
 * Available repayment methods.
 */
const String BALANCEPAYMENTRATIO = 'balancePaymentRatio';
const String BALANCERATERATIO = 'balanceRateRatio';
const String HIGHESTBALANCEFIRST = 'highestBalanceFirst';
const String HIGHESTRATEFIRST = 'highestRateFirst';
const String LOWESTBALANCEFIRST = 'lowestBalanceFirst';
const String LOWESTRATEFIRST = 'lowestRateFirst';
