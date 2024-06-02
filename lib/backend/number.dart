import 'dart:math';

class Number {
  final String value;
  final int base;
  late String binary;

  Number(this.value, this.base) {
    if (base == 2) {
      binary = value;
    } else {
      binary = _toBase(2);
    }
  }

  @override
  String toString() {
    return "[$value]_$base";
  }

  Number convert(int newBase) {
    var newValue = _toBase(newBase);
    return Number(newValue, newBase);
  }

  String _toBase(int newBase) {
    if (newBase == base) {
      return value;
    }

    int decimalNumber = int.parse(value, radix: base);

    if (newBase == 10) {
      return decimalNumber.toString();
    }

    const String digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String result = "";

    if (decimalNumber == 0) {
      result = '0';
    } else {
      while (decimalNumber > 0) {
        int remainder = decimalNumber % newBase;
        result = digits[remainder] + result;
        decimalNumber ~/= newBase;
      }
    }

    return result;
  }

  int compare(Number num2) {
    var x = binary;
    var y = num2.binary;

    return _compareBinary(x, y);
  }

  int _compareBinary(String x, String y) {
    x = x.replaceFirst(RegExp(r'^0+'), '');
    y = y.replaceFirst(RegExp(r'^0+'), '');

    if (x.length > y.length) {
      return 1;
    } else if (x.length < y.length) {
      return -1;
    } else {
      if (x.compareTo(y) > 0) {
        return 1;
      } else if (x.compareTo(y) < 0) {
        return -1;
      } else {
        return 0;
      }
    }
  }

  Number sum(Number num2, int targetBase) {
    String x = binary;
    String y = num2.binary;
    String result;

    result = _addBinary(x, y);

    if (targetBase == 2) {
      return Number(result, 2);
    }

    return Number(result, 2).convert(targetBase);
  }

  String _addBinary(String x, String y) {
    int maxLen = max(x.length, y.length);
    x = x.padLeft(maxLen, '0');
    y = y.padLeft(maxLen, '0');

    String result = '';
    int carry = 0;

    for (int i = maxLen - 1; i >= 0; i--) {
      int bit1 = int.parse(x[i]);
      int bit2 = int.parse(y[i]);

      int total = bit1 + bit2 + carry;

      int resultBit = total % 2;
      result = resultBit.toString() + result;

      carry = total ~/ 2;
    }

    if (carry != 0) {
      result = '1$result';
    }

    return result;
  }

  Number subtract(Number num2, int targetBase) {
    String x = binary;
    String y = num2.binary;
    String result;

    result = subtractBinary(x, y);

    if (targetBase ==  2) {
      return Number(result, 2);
    }

    return Number(result, 2).convert(targetBase);
  }

  String subtractBinary(String x, String y) {
    int maxLen = max(x.length, y.length);
    x = x.padLeft(maxLen, '0');
    y = y.padLeft(maxLen, '0');

    String result = '';
    int borrow = 0;

    for (int i = maxLen - 1; i >= 0; i--) {
      int bit1 = int.parse(x[i]);
      int bit2 = int.parse(y[i]);

      int diff = bit1 - bit2 - borrow;

      if (diff < 0) {
        diff += 2;
        borrow = 1;
      } else {
        borrow = 0;
      }

      result = diff.toString() + result;
    }

    result = result.replaceFirst(RegExp(r'^0+'), '');

    if (result.isEmpty) {
      result = '0';
    }

    return result;
  }

  Number multiply(Number num2, int targetBase) {
    String x = binary;
    String y = num2.binary;

    String result = '0';
    y = y.split('').reversed.join('');

    for (int i = 0; i < y.length; i++) {
      if (y[i] == '1') {
        String shiftedBin1 = x + '0' * i;
        result = _addBinary(result, shiftedBin1);
      }
    }

    if (targetBase == 2) {
      return Number(result, 2);
    }

    return Number(result, 2).convert(targetBase);
  }

  Number divide(Number num2, int targetBase) {
    String x = binary;
    String y = num2.binary;

    if (y == '0') {
      return Number(y, 2);
    }

    x = x.replaceFirst(RegExp(r'^0+'), '');
    y = y.replaceFirst(RegExp(r'^0+'), '');

    if (_compareBinary(x, y) < 0) {
      return Number('0', 2);
    }

    String quotient = '';
    String remainder = x;

    while (_compareBinary(remainder, y) >= 0) {
      String tempDivisor = y;
      String multiple = '1';

      while (_compareBinary(remainder, '${tempDivisor}0') >= 0) {
        tempDivisor += '0';
        multiple += '0';
      }

      remainder = subtractBinary(remainder, tempDivisor);
      quotient = _addBinary(quotient, multiple);
    }

    if (targetBase == 2) {
      return Number(quotient, 2);
    }

    return Number(quotient, 2).convert(targetBase);
  }
}
