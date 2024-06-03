import 'package:arifmetic_operations/backend/problem.dart';
import 'package:flutter/material.dart';

class CheckRowWidget extends StatefulWidget {
  final Problem problem;
  final TextEditingController controller;

  const CheckRowWidget({
    Key? key,
    required this.problem,
    required this.controller,
  }) : super(key: key);

  @override
  State<CheckRowWidget> createState() => _CheckRowWidgetState();
}

class _CheckRowWidgetState extends State<CheckRowWidget> {
  bool result = false;
  bool showResult = false;

  void setResult(bool newValue) {
    setState(() {
      showResult = true;
      result = newValue;
    });
  }

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
              widget.problem.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  enabled: !showResult,
                  controller: widget.controller,
                  decoration:
                      const InputDecoration(labelText: 'Введите значение'),
                ),
              ),
              (!showResult)
                  ? ElevatedButton(
                      onPressed: () {
                        widget.problem.userAnswer = widget.controller.text;
                        if (widget.controller.text ==
                            widget.problem.correctAnswer) {
                          setResult(true);
                          widget.problem.correct = true;
                        } else {
                          setResult(false);
                          widget.problem.correct = false;
                        }
                      },
                      child: const Text('Проверить'),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 8.0),
          showResult
              ? Text(
                  (result) ? 'Правильно' : 'Неправильно',
                  style: TextStyle(
                    color: result ? Colors.green : Colors.red,
                  ),
                )
              : const SizedBox(),
          showResult
              ? Text(
                  'Правильный ответ: ${widget.problem.correctAnswer}',
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
