part of snowball;

/**
 * Payment information.
 */
class Payment {
  num _interest = 0;
  num _principal = 0;
  
  Payment(num principal, [num interest=0]) {
    this.principal = principal;
    this.interest = interest;
  }
  
  num get interest => _interest;
  set interest(num value) {
    _interest = value;
  }
  
  num get principal => _principal;
  set principal(num value) {
    _principal = value;
  }
  
  num get total => _principal + _interest;
}
