import 'package:flutter/services.dart';

class IsbnInputFormatter extends TextInputFormatter {
  static const _groupSizes = [3, 4, 3, 3]; // 978-0345-371-485

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';
    int selectionIndex = newValue.selection.baseOffset;

    for (int i = 0; i < _groupSizes.length && digitsOnly.isNotEmpty; i++) {
      int groupSize = _groupSizes[i];
      int end = (digitsOnly.length < groupSize) ? digitsOnly.length : groupSize;

      formatted += digitsOnly.substring(0, end);
      digitsOnly = digitsOnly.substring(end);

      if (i < _groupSizes.length - 1 && digitsOnly.isNotEmpty) {
        formatted += '-';
      }
    }

    selectionIndex = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
