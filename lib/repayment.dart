part of snowball;

/**
 * Constants for referencing repayment methods.
 */
const String HIGHESTBALANCEFIRST = 'highestBalanceFirst';
const String LOWESTBALANCEFIRST = 'lowestBalanceFirst';

/**
 * Factory class for creating singletons for each repayment method.
 */
class Repayment {
  final Method method;
  static final Map<String, Repayment> _cache = <String, Repayment>{};
  
  factory Repayment(String methodName) {
    if (_cache.containsKey(methodName)) {
      return _cache[methodName];
    } else {
      Method method;
      switch(methodName) {
        case HIGHESTBALANCEFIRST:
          method = new HighestBalanceFirstMethod();
          break;
        case LOWESTBALANCEFIRST:
          method = new LowestBalanceFirstMethod();
          break;
        default:
          throw new Exception('Unknown repayment method: $methodName');
      }
      
      final Repayment repayment = new Repayment._internal(method);
      _cache[methodName] = repayment;
      return repayment;
    }
  }
  
  Repayment._internal(this.method);
  
  List<Debt> sort(List<Debt> debts) => method.sort(debts);
}

/**
 * Interface for repayment methods.
 */
class Method {
  final bool allowCaching = false;
  
  int compare(Debt a, Debt b) {
    throw new Exception('Missing compare function.');
  }
  
  List<Debt> sort(List<Debt> debts) {
    List<Debt> sorted = <Debt>[];
    sorted.addAll(debts);
    sorted.sort(this.compare);
    return sorted;
  }
}

/**
 * Cacheable repayment method.
 */
class CachableMethod extends Method {
  final bool allowCaching = true;
}

/**
 * Method - Highest Balance First
 */
class HighestBalanceFirstMethod extends CachableMethod {
  int compare(Debt a, Debt b) => (b.balance - a.balance).toInt();
}

/**
 * Method - Lowest Balance First
 */
class LowestBalanceFirstMethod extends CachableMethod {
  int compare(Debt a, Debt b) => (a.balance - b.balance).toInt();
}
