// To set Uppercase Keyboard and text field. You have to Use the [UpperCaseTextFormatter] in the [inputFormatters],
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
      );
    } else {
      return const TextEditingValue(
        text: "",
      );
    }
  }
}

class FirstUpperCaseTextFormatter extends TextInputFormatter {
  String capitalizeAllWordsInFullSentence(String str) {
    int i;
    String constructedString = "";
    for (i = 0; i < str.length; i++) {
      if (i == 0) {
        constructedString += str[0].toUpperCase();
      } else if (str[i - 1] == ' ') {
        constructedString += str[i].toUpperCase();
      } else {
        constructedString += str[i];
      }
    }
    return constructedString;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: capitalizeAllWordsInFullSentence(newValue.text),
      selection: newValue.selection,
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimmedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection(
          baseOffset: trimmedText.length,
          extentOffset: trimmedText.length,
        ),
      );
    }

    return newValue;
  }
}

extension StringExtensionFunction on String {
  String stripNumber() {
    return replaceAll(" ", "").replaceAll(",", "").replaceAll("₹", "");
  }

  String formatToShowDate() {
    return DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(this));
  }

  String formatToShowDateTypeTwo() {
    DateTime parseDate = DateFormat("dd-MM-yyyy").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String formatToShowDateTypeThree() {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM, yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  String allWordsCapitilize(String str) {
    if (str.isNotEmpty) {
      return str[0].toUpperCase() + str.substring(1, str.length);
    }
    return "";
  }

  String firstWordCapitilize(String str) {
    if (str.isNotEmpty) {
      if (str.contains(" ")) {
        var splitString = str.split(" ");
        var resultString = "";
        if (splitString[0].isNotEmpty) {
          resultString +=
              "${splitString[0][0].toUpperCase()}${splitString[0].substring(1, splitString[0].length).toLowerCase()}";
        }
        if (splitString[1].isNotEmpty) {
          resultString +=
              " ${splitString[1][0].toUpperCase()}${splitString[1].substring(1, splitString[1].length).toLowerCase()}";
        }
        return resultString;
      }
      return str[0].toUpperCase() + str.substring(1, str.length).toLowerCase();
    }
    return "";
  }

  String capitalize1Word(String value) {
    if (value.trim().isEmpty) return "";
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }
}
