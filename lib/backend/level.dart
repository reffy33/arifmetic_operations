import 'package:arifmetic_operations/backend/number.dart';
import 'package:arifmetic_operations/backend/problem.dart';

class Level {
  final List<Number> numbers;
  final List<Problem> problems;

  Level(this.numbers, this.problems);

  factory Level.createProblems(List<Number> numbers) {
    List<Problem> problems = [];

    int i = 1;
    while (i < numbers.length) {
      var problem = Problem.random(numbers[i - 1], numbers[i]);
      problems.add(problem);
      i += 2;
    }

    if (numbers.length % 2 != 0) {
      var problem = Problem.random(
          numbers[numbers.length - 1], numbers[numbers.length - 2]);
      problems.add(problem);
    }

    return Level(numbers, problems);
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    for (var problem in problems) {
      sb.writeln(problem.toStringFull());
    }

    sb.writeln();
    
    return sb.toString();
  }
}
