import 'dart:io';
import 'package:arifmetic_operations/backend/level.dart';
import 'package:arifmetic_operations/backend/problem.dart';
import 'package:arifmetic_operations/backend/trail.dart';
import 'package:arifmetic_operations/frontend/check_problem_tile.dart';
import 'package:arifmetic_operations/frontend/numbers_table.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class TrialWidget extends StatefulWidget {
  final String? fio;
  final String? trialNumber;
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

  Future<void> _saveResultToFile(int index) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String fileName = 'result.txt';
      if (widget.fio != "" && widget.trialNumber != ""){
        fileName = '${widget.fio}_trial${widget.trialNumber}.txt';
      }
      final file = File(path.join(directory.path, fileName));

      StringBuffer sb = StringBuffer();

      if (widget.fio != null) {
        sb.writeln('ФИО: ${widget.fio}');
      }

      if (widget.trialNumber != null) {
        sb.writeln('Номер прогона: ${widget.trialNumber}');
      }

      sb.writeln();
      sb.writeln(widget.trial.toString());

      String resultString = sb.toString();

      await file.writeAsString(resultString, mode: FileMode.append);

      _showFileSaveDialog(
          'Файл сохранен', 'Файл сохранен по пути:\n${file.path}');

      print('Файл сохранен по пути: ${file.path}');
    } catch (e) {
      print('Ошибка сохранения файла: $e');
      _showFileSaveDialog('Ошибка сохранения файла',
          'Ошибка сохранения файла: ${e.toString()}');
    }
  }

  Future<Directory> getApplicationDocumentsDirectory() async {
    Directory directory;

    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Documents');
    } else if (Platform.isWindows) {
      directory = Directory(
          path.join(Platform.environment['USERPROFILE']!, 'Documents'));
    } else if (Platform.isLinux) {
      directory = Directory(Platform.environment['HOME']!);
    } else {
      throw UnsupportedError('Платформа не поддерживается');
    }

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }

  void _showFileSaveDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
          ? ElevatedButton(
              onPressed: () {
                var newLevel = trial.addLevel();
                currentLevelIndex += 1;
                showNextLevel(newLevel);
              },
              child: const Text('Следующий уровень'),
            )
          : ElevatedButton(
              onPressed: () {
                _saveResultToFile(1);
              },
              child: const Text('Создать протокол прогона'),
            )
    ]);
  }
}
