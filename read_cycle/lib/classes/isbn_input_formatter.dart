import 'package:flutter/services.dart';

class IsbnInputFormatter extends TextInputFormatter {
  static const List<int> _groupSizes = [3, 4, 3, 3]; // 978-0345-371-485

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldText = oldValue.text;
    final newText = newValue.text;

    String newDigits = newText.replaceAll(RegExp(r'\D'), '');

    final oldCursor = oldValue.selection.baseOffset;
    final newCursor = newValue.selection.baseOffset;

    bool isDeleting = newText.length < oldText.length;

    int digitsBeforeCursor = 0;
    for (int i = 0; i < newCursor && i < newText.length; i++) {
      if (RegExp(r'\d').hasMatch(newText[i])) {
        digitsBeforeCursor++;
      }
    }

    // If dash was deleted, remove previous digit from raw digits
    if (isDeleting && oldCursor > 0 && oldCursor <= oldText.length) {
      if (oldText[oldCursor - 1] == '-') {
        int digitIndexToRemove = _getDigitIndexBefore(oldText, oldCursor - 1);
        if (digitIndexToRemove != -1 && digitIndexToRemove < newDigits.length) {
          newDigits = newDigits.substring(0, digitIndexToRemove) + newDigits.substring(digitIndexToRemove + 1);
          digitsBeforeCursor = digitIndexToRemove; // move cursor after previous digit
        }
      }
    }

    // Rebuild the formatted string
    final buffer = StringBuffer();
    int digitIndex = 0;
    int cursorPosition = 0;
    int writtenDigits = 0;

    for (int groupIndex = 0; groupIndex < _groupSizes.length && digitIndex < newDigits.length; groupIndex++) {
      final groupSize = _groupSizes[groupIndex];
      final remaining = newDigits.length - digitIndex;
      final take = remaining >= groupSize ? groupSize : remaining;

      final group = newDigits.substring(digitIndex, digitIndex + take);
      buffer.write(group);

      for (int i = 0; i < group.length; i++) {
        if (writtenDigits < digitsBeforeCursor) {
          cursorPosition++;
        }
        writtenDigits++;
      }

      digitIndex += take;

      // Insert dash if not last group and group is full
      if (take == groupSize && groupIndex < _groupSizes.length - 1) {
        buffer.write('-');
        if (writtenDigits <= digitsBeforeCursor) {
          cursorPosition++;
        }
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }

  int _getDigitIndexBefore(String formattedText, int dashIndex) {
    int digitCount = 0;
    for (int i = 0; i < dashIndex; i++) {
      if (RegExp(r'\d').hasMatch(formattedText[i])) {
        digitCount++;
      }
    }
    return digitCount - 1;
  }
}
