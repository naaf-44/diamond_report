import 'package:diamond_report/utils/regex_data.dart';

class Validation {
  static String? validateNumber(String? value) {

    if (value == null || value.isEmpty) {
      return null;
    } else if (!RegexData.numberRegExp.hasMatch(value)) {
      return 'Please enter a valid input';
    }
    return null;
  }
}