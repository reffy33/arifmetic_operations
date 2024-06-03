import 'dart:math';
import 'package:arifmetic_operations/backend/trail.dart';
import 'package:arifmetic_operations/frontend/trial_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blue),
          displayMedium: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
      home: const MyHomePage(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const MyHomePage(),
      //   '/trial': (context) => const TrialWidget(),
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _fioController = TextEditingController();
  final TextEditingController _trialNumberController = TextEditingController();
  final List<Widget> _widgets = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    _widgets.add(
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      TextField(
        controller: _fioController,
        decoration: const InputDecoration(labelText: 'ФИО'),
      ),
      const SizedBox(height: 20),
      TextField(
        controller: _trialNumberController,
        decoration: const InputDecoration(labelText: 'Номер прогона'),
      ),
      const SizedBox(height: 40),
      Center(
        child: ElevatedButton(
          onPressed: () {
            newTrial();
          },
          child: const Text('Начать прогон'),
        ),
      ),
      const SizedBox(height: 20),
    ]));
    _widgets.add(const SizedBox());
  }

  void newTrial() {
    setState(() {
      var newTrial = Trial.createFirstLevel();
      _widgets.removeLast();
      _widgets.add(TrialWidget(
        trial: newTrial,
        fio: _fioController.text,
        trialNumber: _trialNumberController.text,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Арифметические операции'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _widgets),
          ),
        ));
  }
}
