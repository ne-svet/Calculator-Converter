import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/сalculationHistoryProvider.dart';
import '../widgets/myNavigationBar.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        // Когда данные, предоставляемые провайдером, изменяются,
        // Consumer перестраивается, чтобы отобразить эти изменения в UI
        child: Consumer<CalculationHistoryProvider>(
          builder: (context, historyModel, child) {
            // Если история пуста, отобразить сообщение об этом
            if (historyModel.history.isEmpty) {
              return const Center(
                child: Text(
                  'History is empty',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              // Иначе отобразить элементы списка истории
              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  // Количество элементов в списке равно размеру истории
                  itemCount: historyModel.history.length,
                  // Для каждого элемента истории создать ListTile
                  itemBuilder: (context, index) {
                    final item = historyModel.history[index];
                    return ListTile(
                      title: Text(item.expression),
                      subtitle: Text(
                        item.result,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      trailing: Text(
                        // Вывести дату и время в формате 'yyyy-MM-dd HH:mm'
                        DateFormat('yyyy-MM-dd HH:mm').format(item.date),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
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
