import 'dart:math';

int generateInt(int min, int max) {
  var random = Random();
  return min + random.nextInt(max - min + 1);
}
