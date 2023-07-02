import 'package:flutter/services.dart';

import 'package:flutter/services.dart';

class DateMaskInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String maskedText = _applyDateMask(newValue.text);
    return newValue.copyWith(
        text: maskedText,
        selection: TextSelection.collapsed(offset: maskedText.length));
  }

  String _applyDateMask(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    String formattedDate = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 4) {
        formattedDate += '.';
      }
      formattedDate += digitsOnly[i];
    }

    return formattedDate;
  }
}




class CustomMaskInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String maskedText = _applyDateMask(newValue.text);
    return newValue.copyWith(
        text: maskedText,
        selection: TextSelection.collapsed(offset: maskedText.length));
  }

  String _applyDateMask(String input) {
    String digitsOnly = input.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length > 14) {
      digitsOnly = digitsOnly.substring(0, 14);
    }

    String formattedDate = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 3 || i == 6 || i==9 || i==12) {
        formattedDate += ' ';
      }
      formattedDate += digitsOnly[i];
    }

    return formattedDate;
  }
}
