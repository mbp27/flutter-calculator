import 'package:flutter/material.dart';

enum Focus { start, end }

class FocusPrimes extends ChangeNotifier {
  Focus _focus;

  FocusPrimes(this._focus);

  Focus getFocusPrimes() => _focus;
  void setFocusPrimes(Focus focus) {
    _focus = focus;
    notifyListeners();
  }
}
