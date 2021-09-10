import 'package:calculator/models/calculation.dart';
import 'package:flutter/material.dart';

class History extends ChangeNotifier {
  List<Calculation> _history;

  History(this._history);

  List<Calculation> getHistory() => _history.reversed.toList();
  void setHistory(List<Calculation> history) {
    _history = history;
    notifyListeners();
  }

  Calculation getLast() => _history.last;

  void add(Calculation calculation) {
    _history.add(calculation);
    notifyListeners();
  }

  void clear() {
    _history.clear();
    notifyListeners();
  }
}
