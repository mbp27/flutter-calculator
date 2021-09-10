import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:calculator/models/calculation.dart' as model;
import 'package:calculator/providers/history.dart';

class Calculation extends ChangeNotifier {
  final History history;
  model.Calculation? _calculation;

  Calculation(
    this._calculation, {
    required this.history,
  });

  model.Calculation? getCalculation() => _calculation;
  void setCalculation(model.Calculation calculation) {
    _calculation = calculation;
    notifyListeners();
  }

  void add(String value) {
    model.Calculation calculation = _calculation ?? model.Calculation();
    String question = calculation.question ?? '';
    _calculation = calculation.copyWith(question: question += value);
    notifyListeners();
  }

  void delete() {
    model.Calculation calculation = _calculation ?? model.Calculation();
    String question = calculation.question ?? '';
    if (question.isNotEmpty) {
      _calculation = calculation.copyWith(
          question: question.substring(0, question.length - 1));
    } else {
      clear();
    }
    notifyListeners();
  }

  void ans() {
    model.Calculation calculation = _calculation ?? model.Calculation();
    String question = calculation.question ?? '';
    if (history.getHistory().isEmpty) {
      throw 'History is empty.';
    }
    _calculation = calculation.copyWith(
        question: question += history.getLast().answerDisplay);
    notifyListeners();
  }

  void equals() {
    model.Calculation calculation = _calculation ?? model.Calculation();
    String question = calculation.question ?? '';
    question = question.replaceAll('×', '*');
    question = question.replaceAll('%', '*0.01');
    question = question.replaceAll('÷', '/');
    num? result =
        Parser().parse(question).evaluate(EvaluationType.REAL, ContextModel());
    _calculation =
        calculation.copyWith(question: calculation.question, answer: result);
    history.add(_calculation!);
    notifyListeners();
  }

  void clear() {
    _calculation = null;
    notifyListeners();
  }
}
