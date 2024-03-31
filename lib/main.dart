import 'package:calculator_gadalova/provider/сalculationHistoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'Screens/calculator_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      //создаем и предоставляем объект CalculationHistoryModel, который будет использоваться во всем приложении.
      create: (context) => CalculationHistoryProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    ); // MaterialApp
  }
}
