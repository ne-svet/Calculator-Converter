
import 'package:calculator_gadalova/controllers/firestore_controller.dart';
import 'package:calculator_gadalova/controllers/persistence_controller.dart';
import 'package:flutter/cupertino.dart';

import '../logic/calculation_history.dart';

class CalculationHistoryProvider extends ChangeNotifier {
  //список _history, который хранит историю вычислений
  //List<CalculationHistory> _history = [];

  //List<CalculationHistory> get history => _history;

  PersistenceController persistenceController = FirestoreController();
  //  добавляет новые записи в историю
  Future<void> addCalculationHistory(CalculationHistory ch) async{
    //_history.add(ch);
await persistenceController.saveData(ch);
    notifyListeners(); //оповещаем слушателей, когда история обновляется
  }

//получение данных
  Future<List<CalculationHistory>> getAllCalculationHistory() async{
    //_history.sort();
    return persistenceController.getAllData();
  }

  //удаляем историю
  Future<void> clearHistory() async{
    //_history.clear();
    await persistenceController.deleteData();
    notifyListeners();
  }
}
