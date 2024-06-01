import 'package:arifmetic_operations/backend/number.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Number convert test', () {
    test('', () {
      final num = Number('10', 10);
      expect(num.convert(2).toString(), '[1010]_2');
    });

    test('', () {
      final num = Number('10', 10);
      expect(num.convert(3).toString(), '[101]_3');
    });

    test('', () {
      final num = Number('10', 10);
      expect(num.convert(7).toString(), '[13]_7');
    });

    test('', () {
      final num = Number('255', 10);
      expect(num.convert(16).toString(), '[FF]_16');
    });

    test('', () {
      final num = Number('FF', 16);
      expect(num.convert(2).toString(), '[11111111]_2');
    });

    test('', () {
      final num = Number('1010', 2);
      expect(num.convert(10).toString(), '[10]_10');
    });

    test('', () {
      final num = Number('101', 3);
      expect(num.convert(10).toString(), '[10]_10');
    });

    test('', () {
      final num = Number('13', 7);
      expect(num.convert(10).toString(), '[10]_10');
    });

    test('', () {
      final num = Number('FF', 16);
      expect(num.convert(10).toString(), '[255]_10');
    });
  });

  group('Number sum tests', () {
    test('', () {
      Number num1 = Number('101', 2);
      Number num2 = Number('110', 2);
      Number result = num1.sum(num2, 10);
      expect(result.value, '11');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('15', 10);
      Number num2 = Number('30', 10);
      Number result = num1.sum(num2, 16);
      expect(result.value, '2D');
      expect(result.base, 16);
    });

    test('', () {
      Number num1 = Number('12', 8);
      Number num2 = Number('7', 8);
      Number result = num1.sum(num2, 2);
      expect(result.value, '10001');
      expect(result.base, 2);
    });

    test('', () {
      Number num1 = Number('A', 16);
      Number num2 = Number('B', 16);
      Number result = num1.sum(num2, 10);
      expect(result.value, '21');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('8', 10);
      Number num2 = Number('9', 10);
      Number result = num1.sum(num2, 8);
      expect(result.value, '21');
      expect(result.base, 8);
    });

    test('', () {
      Number num1 = Number('1111', 2);
      Number num2 = Number('1', 2);
      Number result = num1.sum(num2, 16);
      expect(result.value, '10');
      expect(result.base, 16);
    });

    test('', () {
      Number num1 = Number('11101', 2);
      Number num2 = Number('56', 16);
      Number result = num1.sum(num2, 10);
      expect(result.value, '115');
      expect(result.base, 10);
    });
  });

  group('Number subtract tests', () {
    test('', () {
      Number num1 = Number('110', 2);
      Number num2 = Number('101', 2);
      Number result = num1.subtract(num2, 10);
      expect(result.value, '1');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('30', 10);
      Number num2 = Number('15', 10);
      Number result = num1.subtract(num2, 16);
      expect(result.value, 'F');
      expect(result.base, 16);
    });

    test('', () {
      Number num1 = Number('12', 8);
      Number num2 = Number('7', 8);
      Number result = num1.subtract(num2, 2);
      expect(result.value, '101');
      expect(result.base, 2);
    });

    test('', () {
      Number num1 = Number('B', 16);
      Number num2 = Number('A', 16);
      Number result = num1.subtract(num2, 10);
      expect(result.value, '1');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('9', 10);
      Number num2 = Number('8', 10);
      Number result = num1.subtract(num2, 8);
      expect(result.value, '1');
      expect(result.base, 8);
    });

    test('', () {
      Number num1 = Number('1111', 2);
      Number num2 = Number('1', 2);
      Number result = num1.subtract(num2, 16);
      expect(result.value, 'E');
      expect(result.base, 16);
    });
  });

  group('Number multiply tests', () {
    test('', () {
      Number num1 = Number('101', 2);
      Number num2 = Number('110', 2);
      Number result = num1.multiply(num2, 10);
      expect(result.value, '30');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('15', 10);
      Number num2 = Number('2', 10);
      Number result = num1.multiply(num2, 16);
      expect(result.value, '1E');
      expect(result.base, 16);
    });

    test('', () {
      Number num1 = Number('12', 8);
      Number num2 = Number('7', 8);
      Number result = num1.multiply(num2, 2);
      expect(result.value, '110110');
      expect(result.base, 2);
    });

    test('', () {
      Number num1 = Number('A', 16);
      Number num2 = Number('B', 16);
      Number result = num1.multiply(num2, 10);
      expect(result.value, '110');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('8', 10);
      Number num2 = Number('9', 10);
      Number result = num1.multiply(num2, 8);
      expect(result.value, '110');
      expect(result.base, 8);
    });

    test('', () {
      Number num1 = Number('1111', 2);
      Number num2 = Number('10', 2);
      Number result = num1.multiply(num2, 16);
      expect(result.value, '1E');
      expect(result.base, 16);
    });
  });

  group('Number divide tests', () {
    test('', () {
      Number num1 = Number('110', 2);
      Number num2 = Number('10', 2);
      Number result = num1.divide(num2, 10);
      expect(result.value, '3');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('30', 10);
      Number num2 = Number('15', 10);
      Number result = num1.divide(num2, 16);
      expect(result.value, '2');
      expect(result.base, 16);
    });

    test('', () {
      Number num1 = Number('12', 8);
      Number num2 = Number('2', 8);
      Number result = num1.divide(num2, 2);
      expect(result.value, '101');
      expect(result.base, 2);
    });

    test('', () {
      Number num1 = Number('B', 16);
      Number num2 = Number('A', 16);
      Number result = num1.divide(num2, 10);
      expect(result.value, '1');
      expect(result.base, 10);
    });

    test('', () {
      Number num1 = Number('18', 10);
      Number num2 = Number('3', 10);
      Number result = num1.divide(num2, 8);
      expect(result.value, '6');
      expect(result.base, 8);
    });

    test('', () {
      Number num1 = Number('1110', 2);
      Number num2 = Number('10', 2);
      Number result = num1.divide(num2, 16);
      expect(result.value, '7');
      expect(result.base, 16);
    });
  });
}