import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

void main() => runApp(MyApp());

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
    // _writeResultToFile(index);
  }

  Future<void> _writeResultToFile(int index) async {
    final directory = await getApplicationDocumentsDirectory();
    String desktopPath;
    if (Platform.isWindows) {
      desktopPath = path.join(directory.parent.path, 'Desktop');
    } else if (Platform.isMacOS || Platform.isLinux) {
      desktopPath = path.join(directory.parent.path, 'Desktop');
    } else {
      throw UnsupportedError('Unsupported platform');
    }
    final file = File('$desktopPath/results.txt');
    String resultString = 'Строка ${index + 1}: ${_checkControllers[index].text} - ${_results[index]}\n';
    await file.writeAsString(resultString, mode: FileMode.append);
  }

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
              TextField(
                controller: _fioController,
                decoration: InputDecoration(labelText: 'ФИО'),
              ),
              TextField(
                controller: _textController,
                decoration: InputDecoration(labelText: 'Текстовое поле'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Начать'),
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
