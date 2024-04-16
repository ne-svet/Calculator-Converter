import 'dart:ui';

import 'package:calculator_gadalova/logic/calculator_logic.dart';

import '../provider/сalculationHistoryProvider.dart';
import 'calculation_history.dart';

class ConverterLogic extends CalculatorLogic {
  String txtConverted = "";
  bool flag = true;

  ConverterLogic({
    required CalculationHistoryProvider historyProvider,
    required VoidCallback updateStateCallback,
  }) : super(
          historyProvider: historyProvider,
          updateStateCallback: updateStateCallback,
        );

  // очистить экран
  @override
  void clearAll() {
    txtConverted = '';
    super.clearAll();
  }

  //конвертер
  void convertKilometersMiles() {
    double kilometers;
    double miles;
    String convFrom = 'Kilometrs';
    String convTo = 'Miles';

    try {
      if (txtToDisplay.isEmpty) {
        return;
      } else if (flag == true) {
        // 1 kilometer = 0.621371 miles
        kilometers = double.parse(txtToDisplay);
        miles = kilometers * 0.621371;
        miles = double.parse(miles.toStringAsFixed(5));
        txtConverted = miles.toString();
        convFrom = 'Kilometrs';
        convTo = 'Miles';
      } else if (flag == false) {
        // 1 mile = 1.60934 kilometers
        miles = double.parse(txtToDisplay);
        kilometers = miles * 1.60934;
        kilometers = double.parse(kilometers.toStringAsFixed(5));
        txtConverted = kilometers.toString();
        convFrom = 'Miles';
        convTo = 'Kilometrs';
      }
      // Добавляем расчет в историю, создав объект CalculationHistory
      historyProvider.addCalculationHistory(CalculationHistory(
        '$txtToDisplay $convFrom >',
        '$txtConverted $convTo',
        DateTime.now(),
      ));
      updateStateCallback();
    } catch (e) {
      txtToDisplay = 'Error';
      updateStateCallback();
    }
  }

  //поменять единицы
  void changeUnits() {
    flag = !flag;
    updateStateCallback();
  }
}
