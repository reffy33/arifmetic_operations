import 'package:arifmetic_operations/backend/trail.dart';
import 'package:arifmetic_operations/frontend/numbers_table.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _fioController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final List<String> _strings = ['Строка 1'];
  final List<TextEditingController> _checkControllers = [TextEditingController()];
  final List<String> _results = [''];

  void _checkInput(int index) {
    setState(() {
      _results[index] = _checkControllers[index].text == _strings[index] ? 'Правильно' : 'Неправильно';
      if (index == _strings.length - 1) {
        _strings.add('Строка ${_strings.length + 1}');
        _checkControllers.add(TextEditingController());
        _results.add('');
      }
    });
  }

  Future<void> _saveResultToFile(int index) async {
    try {
      // Получение пути к директории документов
      final directory = await getApplicationDocumentsDirectory1();
      final file = File(path.join(directory.path, 'results.txt'));

      // Формирование строки результата
      String resultString =
          'Строка ${index + 1}: ${_checkControllers[index].text} - ${_results[index]}\n';

      // Запись строки результата в файл
      await file.writeAsString(resultString, mode: FileMode.append);

      // Показать всплывающее сообщение о сохранении файла
      _showFileSavedDialog(file.path);

      print('Файл сохранен по пути: ${file.path}');
    } catch (e) {
      print('Ошибка сохранения файла: $e');
      // Показать всплывающее сообщение об ошибке сохранения файла
      _showFileErrorDialog(e.toString());
    }
  }

  Future<Directory> getApplicationDocumentsDirectory1() async {
    Directory directory;

    if (Platform.isIOS || Platform.isMacOS) {
      directory = Directory(path.join(Platform.environment['HOME']!, 'Documents'));
    } else if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Documents');
    } else if (Platform.isWindows) {
      directory = Directory(path.join(Platform.environment['USERPROFILE']!, 'Documents'));
    } else {
      throw UnsupportedError('Платформа не поддерживается');
    }

    // Создаем директорию, если она не существует
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }

  void _showFileSavedDialog(String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Файл сохранен'),
          content: Text('Файл сохранен по пути:\n$filePath'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showFileErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ошибка сохранения файла'),
          content: Text('Произошла ошибка при сохранении файла:\n$error'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveResultsToFile() async {
    try {
      // Получение пути к директории документов
      final directory = await getApplicationDocumentsDirectory1();
      final file = File(path.join(directory.path, 'results.txt'));

      // Запись всех строк результатов в файл
      String resultString = '';
      for (int i = 0; i < _results.length; i++) {
        resultString += 'Строка ${i + 1}: ${_checkControllers[i].text} - ${_results[i]}\n';
      }

      await file.writeAsString(resultString);

      // Показать всплывающее сообщение о сохранении файла
      _showFileSavedDialog(file.path);

      print('Файл сохранен по пути: ${file.path}');
    } catch (e) {
      print('Ошибка сохранения файла: $e');
      // Показать всплывающее сообщение об ошибке сохранения файла
      _showFileErrorDialog(e.toString());
    }
  }

  final trial = Trial.createFirstLevel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пример приложения'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              NumbersTable(numbers: trial.initialNumbers),
              TextField(
                controller: _fioController,
                decoration: InputDecoration(labelText: 'ФИО'),
              ),
              SizedBox(height: 20), // Больший отступ между полями ввода
              TextField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Текстовое поле'),
              ),
              SizedBox(height: 40), // Больший отступ перед кнопкой "Начать"
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Начать'),
                ),
              ),
              SizedBox(height: 20),
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: List.generate(
                      11,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Столбец ${index + 1}'),
                      ),
                    ),
                  ),
                  TableRow(
                    children: List.generate(
                      11,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Строка 1, столбец ${index + 1}'),
                      ),
                    ),
                  ),
                  TableRow(
                    children: List.generate(
                      11,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Строка 2, столбец ${index + 1}'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ...List.generate(
                _strings.length,
                (index) => CheckRowWidget(
                  title: _strings[index],
                  controller: _checkControllers[index],
                  result: _results[index],
                  onCheck: () => _checkInput(index),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Перейти на следующий уровень
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Переход на следующий уровень')),
                        );
                      },
                      child: Text('Перейти на следующий уровень'),
                    ),
                    SizedBox(height: 20), // Отступ между кнопками
                    ElevatedButton(
                      onPressed: _saveResultsToFile,
                      child: Text('Записать результаты в файл'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckRowWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String result;
  final VoidCallback onCheck;

  const CheckRowWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.result,
    required this.onCheck,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Введите значение'),
                ),
              ),
              ElevatedButton(
                onPressed: onCheck,
                child: Text('Проверить'),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            result,
            style: TextStyle(
              color: result == 'Правильно' ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
