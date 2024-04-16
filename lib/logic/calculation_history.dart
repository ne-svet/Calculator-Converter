class CalculationHistory implements Comparable<CalculationHistory> {
  final String expression;
  final String result;
  final DateTime date;

  CalculationHistory(
    this.expression,
    this.result,
    this.date,
  );

  Map<String, Object> toMap() {
    //сериализация объектов в данные для БД
    return {
      'expression': expression,
      'result': result,
      'date': date.toString(),
    };
  }

  //преобразование данных для загрузки из БД
  //пишем функцию fromMap
  factory CalculationHistory.fromMap(Map<String, dynamic> map) {
    CalculationHistory ch = CalculationHistory(
      map['expression'],
      map['result'],
      DateTime.parse(map['date']),

    );
    return ch;
  }

  @override
  int compareTo(CalculationHistory other) {
    if (date.compareTo(other.date) == -1) {
      return 1;
    } else if (date.compareTo(other.date) == 0) {
      return 0;
    } else {
      return -1;
    }
  }


}