import 'package:arifmetic_operations/backend/number.dart';

class Problem {
  final Number num1;
  final Number num2;
  final String operation;
  final int targetBase;
  late String correctAnswer;
  late String userAnswer;

  Problem(this.num1, this.num2, this.operation, this.targetBase) {
    correctAnswer = _getAnswer().value;
  }
  
  Number _getAnswer() {
    if (operation == '+') {
      return num1.sum(num2, targetBase);
    }
    if (operation == '-') {
      return num1.subtract(num2, targetBase);
    }
    if (operation == '*') {
      return num1.multiply(num2, targetBase);
    }
    if (operation == '/') {
      return num1.divide(num2, targetBase);
    }
    throw Exception('Unknown operation symbol');
  }

  @override
  String toString() {
    var num1String = num1.toString();
    var num2String = num2.toString();
    return "$num1String $operation $num2String = ";
  }
  
  String stringWithAnswer() {
    var num1String = num1.toString();
    var num2String = num2.toString();
    return "$num1String $operation $num2String = $correctAnswer";
  }

  String isUserRight() {
    return (userAnswer == correctAnswer) ? 'Верно' : 'Неверно';
  }

  String toFile() {
    StringBuffer sb = StringBuffer();
    var num1String = num1.toString();
    var num2String = num2.toString();
    var rightString = isUserRight();
    sb.writeln("$num1String $operation $num2String = ");
    sb.writeln("Основание в котором нужно дать ответ: $targetBase");
    sb.writeln("Правильный ответ: $correctAnswer");
    sb.writeln("Ваш ответ: $userAnswer");
    sb.writeln(rightString);
    return sb.toString();
  }
}