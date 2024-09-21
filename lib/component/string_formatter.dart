import 'package:intl/intl.dart';

String priceFormat(String input) {
  int number = int.parse(input);

  // Create a NumberFormat for thousands with dots
  var formatter =
      NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

  // Format the number
  String formattedNumber = formatter.format(number);
  return formattedNumber;
}

String shortenKabupaten(String input) {
  if (input.toLowerCase().startsWith("kabupaten")) {
    return input.replaceFirst("Kabupaten", "Kab.");
  }
  return input;
}

String cleanAndCombineText(String input) {
  // Menghilangkan karakter newline dan menggabungkan menjadi satu kalimat
  String cleanedText = input.replaceAll(RegExp(r'\r\n|\r|\n'), ' ');
  // Menghapus spasi berlebih jika ada
  cleanedText = cleanedText.replaceAll(RegExp(r'\s+'), ' ').trim();
  return cleanedText;
}