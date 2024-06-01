import 'package:arifmetic_operations/backend/level.dart';
import 'package:arifmetic_operations/backend/number.dart';

class Trial {
  final List<Number> initialNumbers;
  late List<Level> levels;
  late int rightAnswers;
  late double procentRight;

  Trial({required this.initialNumbers});
}