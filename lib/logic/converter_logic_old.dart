// import 'dart:ui';
//
// import '../provider/сalculationHistoryProvider.dart';
//
// class ConverterLogic {
//   String txtConverted = "";
//   String txtToDisplay = "";
//   bool flag = true;
//
//
//
//   // обновление состояния на экране
//   VoidCallback updateStateCallback;
//
//   ConverterLogic({
//     required this.historyProvider,
//     required this.updateStateCallback});
//
//   //добавляем value в выражение
//   void appendValue(String value) {
//     // Иначе, добавляем оператор к выражению
//     txtToDisplay += value;
//     updateStateCallback();
//   }
//
//   //delete function последнюю цифру
//
//   void backsp() {
//     if (txtToDisplay.isNotEmpty) {
//       txtToDisplay = txtToDisplay.substring(0, txtToDisplay.length - 1);
//       updateStateCallback();
//     }
//   }
//
//   // очистить экран
//
//   void clearAll() {
//     txtToDisplay = '';
//     txtConverted = '';
//     updateStateCallback();
//   }
//
//   //конвертер
//   void convertKilometersMiles() {
//     double kilometers;
//     double miles;
//
//     if (txtToDisplay.isEmpty) {
//       return;
//     } else if (flag == true) {
//       // 1 kilometer = 0.621371 miles
//       kilometers = double.parse(txtToDisplay);
//       miles = kilometers * 0.621371;
//       miles = double.parse(miles.toStringAsFixed(5));
//       txtConverted = miles.toString();
//     } else if (flag == false) {
//       // 1 mile = 1.60934 kilometers
//       miles = double.parse(txtToDisplay);
//       kilometers = miles * 1.60934;
//       kilometers = double.parse(kilometers.toStringAsFixed(5));
//       txtConverted = kilometers.toString();
//     }
//
//     //обновляем состояние
//     updateStateCallback();
//   }
//
//   //поменять единицы
//   void changeUnits() {
//     flag = !flag;
//     updateStateCallback();
//   }
// }