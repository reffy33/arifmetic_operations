import 'package:arifmetic_operations/backend/trail.dart';
import 'package:arifmetic_operations/frontend/numbers_table.dart';
import 'package:flutter/material.dart';

class TrialWidget extends StatefulWidget {
  final String? fio;
  final int? trialNumber;
  final Trial trial;
  const TrialWidget({super.key, this.fio, this.trialNumber, required this.trial});

  @override
  State<TrialWidget> createState() => _TrialWidgetState();
}

class _TrialWidgetState extends State<TrialWidget> {
  // final trial = Trial.createFirstLevel();
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Начальные данные прогона:', style: TextStyle(fontSize: 20)),
      NumbersTable(numbers: widget.trial.initialNumbers)
      ]);
  }
}