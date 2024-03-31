import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

import '../buttons/button_values.dart';
import '../provider/сalculationHistoryProvider.dart';
import 'calculation_history.dart';

class CalculatorLogic {
  //все используемые переменные
  String expression = '';
  String txtToDisplayExpression = '';
  String txtToDisplay = '';
  String tmpValue = '';

  // Добавляем переменную для хранения экземпляра CalculationHistoryProvider
  CalculationHistoryProvider historyProvider;

  // обновление состояния на экране
  VoidCallback updateStateCallback;

  //конструктор
  CalculatorLogic({
    required this.historyProvider,
    required this.updateStateCallback,
  });

  // Method to set the callback
  void setUpdateStateCallback(VoidCallback callback) {
    updateStateCallback = callback;
  }

  //##############################################
  // FUNCTIONS
  //##############################################

  //удаляем введенные перед числом нули

  String removeZeros(String value) {
    value = value.replaceAll(RegExp(r'0*$'), '');
    if (value.endsWith('.')) {
      value = value.replaceAll('.', '');
    }
    return value;
  }

//##############################################

  //добавляем value в выражение
  void appendValue(String value) {
    // Проверяем, является ли введенный символ арифметическим оператором
    if ([Buttons.add, Buttons.subtract, Buttons.multiply, Buttons.divide]
        .contains(value)) {
      tmpValue = '';
      // Проверяем, был ли введен арифметический оператор последним
      if (expression.isNotEmpty &&
          [Buttons.add, Buttons.subtract, Buttons.multiply, Buttons.divide]
              .contains(expression[expression.length - 1])) {
        // Если да, то заменяем последний введенный оператор на новый
        expression = expression.substring(0, expression.length - 1) + value;
      } else {
        // Иначе, добавляем оператор к выражению
        expression += value;
      }
    } else {
      // Если введенный символ не является оператором, добавляем его к выражению
      tmpValue += value;
      txtToDisplay = tmpValue;
      expression += value;
    }

    txtToDisplayExpression = expression;
    updateStateCallback();
  }

  //##############################################

  //удаляем последнюю цифру

  void backsp() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
      txtToDisplayExpression = expression;
      if(tmpValue.isNotEmpty){
        tmpValue = tmpValue.substring(0, tmpValue.length - 1);
        txtToDisplay = tmpValue;
      }
      else {
        tmpValue = '';
      }

      updateStateCallback();
    }
  }

  //##############################################
  // очистить экран

  void clearAll() {
    expression = '';
    txtToDisplayExpression = '';
    txtToDisplay = '';
    tmpValue = '';
    updateStateCallback();
  }

  //##############################################
  // процент

  void convertToPercentage() {
    //ex: 2+3
    if (expression.isNotEmpty) {
      // посчитать перед переводом в прценты
      calculate();
    } else {
      return;
    }
    // переводим String в Double
    final number = double.parse(txtToDisplay);
    txtToDisplay = "${(number / 100)}";
    expression = txtToDisplay;
    updateStateCallback();
  }

  //##############################################
  // калькулируем

  void calculate() {
    // Заменяем символ 'x' на оператор '*' и удаляем символ '='
    String expressionFinal =
        expression.replaceAll('x', '*').replaceAll('=', '').replaceAll('%', '');

    try {
      Parser p = Parser();
      Expression exp = p.parse(expressionFinal);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      txtToDisplay = eval.toStringAsFixed(3);
      txtToDisplay = removeZeros(txtToDisplay);
      expression = txtToDisplay;

      // Добавляем расчет в историю, создав объект CalculationHistory
      historyProvider.addToHistory(CalculationHistory(
        expression: txtToDisplayExpression,
        result: txtToDisplay,
        date: DateTime.now(),
      ));
      updateStateCallback();
    } catch (e) {
      txtToDisplay = 'Error';
      updateStateCallback();
    }
  }
}
