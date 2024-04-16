import 'package:calculator_gadalova/logic/calculation_history.dart';


//абстрактный класс, он же интерфейс.
// Которые будем использовать в контроллере
abstract class PersistenceController {

  //соединение с БД
  Future<void> init();

  //получить все данные из объектов PhotoMemory
  Future<List<CalculationHistory>> getAllData();

  //сохранение данных
  Future<void> saveData(CalculationHistory calculationHistory);

  //удаление данных
  Future<void> deleteData();

}
