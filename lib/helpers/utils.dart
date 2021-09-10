class Utils {
  Utils._();

  static bool isOperator(String x) {
    return (x == '%' ||
        x == '÷' ||
        x == '×' ||
        x == '-' ||
        x == '+' ||
        x == '=');
  }

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();

  static bool isPrime(int x) {
    int factors = 0;

    for (int start = 1; start <= x; start++) {
      if (x % start == 0) {
        factors++;
      }
    }
    return factors <= 2;
  }

  static List<int> getPrimes(int start, int end) {
    List<int> primes = [];
    for (var i = start; i <= end; i++) {
      if (isPrime(i)) {
        primes.add(i);
      }
    }
    return primes;
  }
}
