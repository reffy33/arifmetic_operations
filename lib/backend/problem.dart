import 'dart:math';
import 'package:arifmetic_operations/backend/number.dart';

class Problem {
  final Number num1;
  final Number num2;
  final String operation;
  final int targetBase;
  late String correctAnswer;
  String? userAnswer;

  Problem(this.num1, this.num2, this.operation, this.targetBase) {
    correctAnswer = _getAnswer().value;
  }

  factory Problem.random(Number num1, Number num2) {
    List<String> operations;
    var random = Random();

    if (num1.compare(num2) < 1) {
      operations = ['+', '*'];
    } else if (num2.value == '0') {
      operations = ['+', '-', '*'];
    } else {
      operations = ['+', '-', '*', '/'];
    }

    String operation = operations[random.nextInt(operations.length)];
    int targetBase = 2 + random.nextInt(10);
    return Problem(num1, num2, operation, targetBase);
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
    StringBuffer sb = StringBuffer();
    sb.writeln("Основание в котором нужно дать ответ: $targetBase");
    sb.writeln("$num1String $operation $num2String = ");
    return sb.toString();
  }

  String isUserRight() {
    return (userAnswer == correctAnswer) ? 'Верно' : 'Неверно';
  }

  String toStringFull() {
    StringBuffer sb = StringBuffer();
    var num1String = num1.toString();
    var num2String = num2.toString();
    var rightString = isUserRight();
    sb.writeln("$num1String $operation $num2String = ");
    sb.writeln("Основание в котором нужно дать ответ: $targetBase");
    sb.writeln("Правильный ответ: $correctAnswer");
    // if (!(userAnswer == null)) {
    //   sb.writeln("Ваш ответ: $userAnswer");
    //   sb.writeln(rightString);
    // }
    return sb.toString();
  }
}
