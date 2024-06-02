import 'dart:math';
import 'package:arifmetic_operations/backend/level.dart';
import 'package:arifmetic_operations/backend/number.dart';

class Trial {
  final List<Number> initialNumbers;
  final List<Level> levels;
  final int levelCount;
  late Level currentLevel;
  late int rightAnswers;
  late double procentRight;

  Trial(
      {required this.initialNumbers,
      required this.levels,
      required this.levelCount,
      required this.currentLevel});

  factory Trial.createFirstLevel() {
    var random = Random();
    var numbersCount = 2 + random.nextInt(14);
    var levelCount = 1 + random.nextInt(10);

    List<Number> initialNumbers = [];
    for (int i = 0; i < numbersCount; i++) {
      int randomBase = 1 + random.nextInt(11);
      int randomNumber = 1 + random.nextInt(1001);

      var num = Number(randomNumber.toString(), 10).convert(randomBase);
      initialNumbers.add(num);
    }

    Level level = Level.createProblems(initialNumbers);

    return Trial(
        initialNumbers: initialNumbers,
        levelCount: levelCount,
        levels: [level],
        currentLevel: level);
  }

  Level addLevel() {
    var random = Random();
    int numbersCount;
    if (initialNumbers.length == 2) {
      numbersCount = 2;
    } else {
      numbersCount = 2 + random.nextInt(initialNumbers.length - 2);
    }
    List<Number> newNumbers = [];

    for (int i = 0; i < numbersCount; i++) {
      var randomIndex = random.nextInt(initialNumbers.length);
      newNumbers.add(initialNumbers[randomIndex]);
    }

    Level newLevel = Level.createProblems(newNumbers);
    currentLevel = newLevel;
    levels.add(newLevel);
    return newLevel;
  }

  @override
  String toString() {
    StringBuffer sb = StringBuffer();

    for (int i = 0; i < levels.length; i++) {
      sb.writeln('Уровень $i');
      sb.writeln(levels[i].toString());
      sb.writeln();
    }

    return sb.toString();
  }
}
