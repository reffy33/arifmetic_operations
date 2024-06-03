import 'package:flutter/material.dart';
import 'package:arifmetic_operations/backend/problem.dart';

class ProblemListWidget extends StatelessWidget {
  final List<Problem> problems;

  const ProblemListWidget(this.problems, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: problems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(problems[index].toString()),
        );
      },
    );
  }
}
