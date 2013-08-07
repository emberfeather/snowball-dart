library debt;

/**
 * Debt class for describing and working with specific debt information.
 */
class Debt {
  var label;
  num balance;
  num rate;
  num minPayment;
  
  Debt(this.label, this.balance, this.rate, this.minPayment);
}
