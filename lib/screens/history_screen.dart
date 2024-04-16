import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/calculation_history.dart';
import '../provider/сalculationHistoryProvider.dart';
import '../widgets/myNavigationBar.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {

  //конструктор
  HistoryScreen ({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        // Когда данные, предоставляемые провайдером, изменяются,
        // Consumer перестраивается, чтобы отобразить эти изменения в UI
        //поскольку это асинхронная операция в будущем - то FutureBuilder
        child: SingleChildScrollView(
          child: FutureBuilder<List<CalculationHistory>>(
            //задаем функцию достать историю
            future: Provider.of<CalculationHistoryProvider>(context).getAllCalculationHistory(),
            //какой виджет показывать ---->
              builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData
              && snapshot.data!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: snapshot.data!.map((calculationHistory) {
                    Column col = Column(
                      children: [
                        Text(
                          '${DateFormat('yyyy-MM-dd HH:mm').format(
                              calculationHistory.date)} '
                        ),
                        Text(
                              '${calculationHistory.expression} ${calculationHistory.result} ',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 2,
                            color: Colors.black12,
                          ),
                        )
                      ],
                    );
                    return col;
                  }).toList(),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(child: Text('History is empty now'),);
              } else {
                return Center(
                  child: Text('Loading...'),
                );
              }    }
          ),

        ),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300),
        onPressed: () {
          // Очистить историю при нажатии на кнопку
          Provider.of<CalculationHistoryProvider>(context, listen: false)
              .clearHistory();
        },
        child: const Text(
          'Clear history',
          style: TextStyle(
              color: Colors.black,
              fontSize: 15),
        ),
      ),
    );
  }
}