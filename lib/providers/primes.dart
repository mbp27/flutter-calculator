import 'package:flutter/material.dart' hide Focus;

import 'package:calculator/helpers/utils.dart';
import 'package:calculator/models/primes.dart' as model;
import 'package:calculator/providers/focus_primes.dart';

class Primes extends ChangeNotifier {
  final FocusPrimes focusPrimes;
  model.Primes _primes;

  Primes(this._primes, {required this.focusPrimes});

  model.Primes getPrimes() => _primes;
  void setPrimes(model.Primes primes) {
    _primes = primes;
    notifyListeners();
  }

  void add(String value) {
    if (_primes.start <= 9999999) {
      if (focusPrimes.getFocusPrimes() == Focus.start) {
        int start = int.parse(_primes.start.toString() + value);
        _primes = _primes.copyWith(
          start: start,
          result: Utils.getPrimes(start, _primes.end),
        );
      } else {
        int end = int.parse(_primes.end.toString() + value);
        _primes = _primes.copyWith(
          end: end,
          result: Utils.getPrimes(_primes.start, end),
        );
      }
    }
    notifyListeners();
  }

  void delete() {
    if (focusPrimes.getFocusPrimes() == Focus.start) {
      String startString = _primes.start.toString();
      int start = int.parse(startString.substring(0, startString.length - 1));
      _primes = _primes.copyWith(
        start: start,
        result: Utils.getPrimes(start, _primes.end),
      );
    } else {
      String endString = _primes.end.toString();
      int end = int.parse(endString.substring(0, endString.length - 1));
      _primes = _primes.copyWith(
        end: end,
        result: Utils.getPrimes(_primes.start, end),
      );
    }
    notifyListeners();
  }

  void clear() {
    _primes = model.Primes(
      start: 0,
      end: 0,
      result: [0],
    );
    notifyListeners();
  }
}
