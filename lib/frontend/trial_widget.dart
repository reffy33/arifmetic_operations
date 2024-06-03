import 'package:arifmetic_operations/backend/level.dart';
import 'package:arifmetic_operations/backend/problem.dart';
import 'package:arifmetic_operations/backend/trail.dart';
import 'package:arifmetic_operations/frontend/check_problem_tile.dart';
import 'package:arifmetic_operations/frontend/numbers_table.dart';
import 'package:flutter/material.dart';

class TrialWidget extends StatefulWidget {
  final String? fio;
  final int? trialNumber;
  final Trial trial;
  const TrialWidget(
      {super.key, this.fio, this.trialNumber, required this.trial});

  @override
  State<TrialWidget> createState() => _TrialWidgetState();
}

class _TrialWidgetState extends State<TrialWidget> {
  var contorllers = [];
  Widget levelWidget = const SizedBox();
  int currentLevelIndex = 0;

  void showNextLevel(Level level) {
    setState(() {
      levelWidget = showLevel(level);
    });
  }

  List<Widget> createProblemsList(List<Problem> problems) {
    List<Widget> problemsWidget = [];
    for (int i = 0; i < problems.length; i++) {
      contorllers.add(TextEditingController());
      problemsWidget.add(CheckRowWidget(
        problem: problems[i],
        controller: contorllers[i],
      ));
    }
    return problemsWidget;
  }

  Widget showLevel(Level level) {
    return Column(
      children: [
        Text('Уровень $currentLevelIndex',
            style: const TextStyle(fontSize: 20)),
        const Text('Числа для этого уровня:', style: TextStyle(fontSize: 20)),
        NumbersTable(numbers: level.numbers),
        const SizedBox(height: 30),
        ...createProblemsList(level.problems)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var trial = widget.trial;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Количество уровней m = ${trial.levelCount}',
          style: const TextStyle(fontSize: 20)),
      const Text('Начальные данные прогона:', style: TextStyle(fontSize: 20)),
      NumbersTable(numbers: trial.initialNumbers),
      const SizedBox(height: 30),
      showLevel(trial.currentLevel),
      (currentLevelIndex < trial.levelCount - 1)
      ?
      ElevatedButton(
        onPressed: () {
          var newLevel = trial.addLevel();
          currentLevelIndex += 1;
          showNextLevel(newLevel);
        },
        child: const Text('Следующий уровень'),
      )
      : ElevatedButton(
        onPressed: () {
          print('File!');
        },
        child: const Text('Создать протокол прогона'),
      )
    ]);
  }
}
