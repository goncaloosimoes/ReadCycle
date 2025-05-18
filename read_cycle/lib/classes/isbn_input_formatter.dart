import 'package:flutter/services.dart';

class IsbnInputFormatter extends TextInputFormatter {
  static const List<int> _groupSizes = [3, 4, 3, 3]; // 978-0345-371-485

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // Extract digits only
    String digits = newText.replaceAll(RegExp(r'\D'), '');

    // Calculate how many digits were before the original cursor
    int rawCursorPosition = newValue.selection.baseOffset;
    int digitsBeforeCursor = 0;
    for (int i = 0; i < rawCursorPosition && i < newText.length; i++) {
      if (RegExp(r'\d').hasMatch(newText[i])) {
        digitsBeforeCursor++;
      }
    }

    // Format digits into groups
    StringBuffer formatted = StringBuffer();
    int usedDigits = 0;
    int cursorPosition = 0;
    int digitCount = 0;

    for (int i = 0; i < _groupSizes.length && usedDigits < digits.length; i++) {
      int groupSize = _groupSizes[i];
      int remaining = digits.length - usedDigits;
      int count = remaining >= groupSize ? groupSize : remaining;

      String group = digits.substring(usedDigits, usedDigits + count);
      formatted.write(group);

      for (int j = 0; j < group.length; j++) {
        if (digitCount < digitsBeforeCursor) {
          cursorPosition++;
          digitCount++;
        }
      }

      usedDigits += count;

      // Add dash if group is full and more digits exist
      if (count == groupSize && i < _groupSizes.length - 1 && usedDigits < digits.length + 1) {
        formatted.write('-');
        if (digitCount < digitsBeforeCursor) {
          cursorPosition++; // Move cursor after dash too
        }
      }
    }

    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
