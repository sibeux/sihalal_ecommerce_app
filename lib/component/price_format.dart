import 'package:intl/intl.dart';

String priceFormat(String input) {
  int number = int.parse(input);

  // Create a NumberFormat for thousands with dots
  var formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

  // Format the number
  String formattedNumber = formatter.format(number);
  return formattedNumber;
}
