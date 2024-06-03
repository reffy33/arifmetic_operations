import 'package:arifmetic_operations/backend/number.dart';
import 'package:flutter/material.dart';

class NumbersTable extends StatelessWidget {
  final List<Number> numbers;

  const NumbersTable({super.key, required this.numbers});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: List.generate(
            numbers.length + 1,
            (index) => 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(index == 0 ? 'j' : (index - 1).toString()),
              ),
            ),
          ),
        ),
        TableRow(
          children: List.generate(
            numbers.length + 1,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(index == 0 ? 'k' : numbers[index - 1].base.toString()),
              ),
            ),
          ),
        ),
        TableRow(
          children: List.generate(
            numbers.length + 1,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(index == 0 ? 'y' : numbers[index - 1].value),
              ),
            ),
          ),
        ),
      ],
    );
  }
}