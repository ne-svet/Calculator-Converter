import 'package:flutter/cupertino.dart';

import '../logic/calculation_history.dart';

class CalculationHistoryProvider extends ChangeNotifier {
  //список _history, который хранит историю вычислений
  final List<CalculationHistory> _history = [];

  List<CalculationHistory> get history => _history;

  //  добавляет новые записи в историю
  void addToHistory(CalculationHistory entry) {
    _history.insert(0, entry);
    notifyListeners(); //оповещаем слушателей, когда история обновляется
  }

  //удаляем историю
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
