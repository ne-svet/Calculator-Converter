import 'package:calculator_gadalova/controllers/persistence_controller.dart';
import 'package:calculator_gadalova/logic/calculation_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FirestoreController implements PersistenceController {

  late FirebaseFirestore db;


  @override
  Future<void> deleteData() async{
    await init();
    //получаем базу для удаления
    QuerySnapshot snapshot = await db.collection('calculatorHistory')
        .get();
    // Проверяем, есть ли документы для удаления
    if (snapshot.docs.isNotEmpty) {
      // Используем цикл для удаления каждого документа
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      print('Nothing to delete');
    }
  }

  //получаем список всех CalculationHistory из Firebase
  @override
  Future<List<CalculationHistory>> getAllData() async {
    await init();
    //получаем документы из коллекции calculatiionHistory в Map формате
    QuerySnapshot snapshot = await db.collection('calculatorHistory')
        //сортируем по дате
        .orderBy('date', descending: true)
        .get();
    //обрабатываем snapshot,
    // из каждого документа docs делаемCalculationHistory
    //получаем список и возвращаем history
    List<CalculationHistory> calcHistory = snapshot.docs
        .map((doc) => CalculationHistory.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return calcHistory;
  }

  //инициализация Firebase
  @override
  Future<void> init() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //инициализируется БД (следуем инструкции)
    db = FirebaseFirestore.instance;
  }

  @override
  //async
  Future<void> saveData(CalculationHistory calculationHistory) async {
  await init();
  //добавляем объект в map формате
  db.collection('calculatorHistory').add(calculationHistory.toMap());
  }
  
}