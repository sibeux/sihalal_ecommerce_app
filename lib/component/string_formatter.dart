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

String timeAgo(String dateTimeString) {
  // Parsing input string ke DateTime
  DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
  
  Duration diff = DateTime.now().difference(dateTime);
  
  if (diff.inDays == 0) {
    // Jika hari ini
    return "hari ini";
  } else if (diff.inDays == 1) {
    // Jika kemarin
    return "kemarin";
  } else if (diff.inDays <= 7) {
    // Jika dalam seminggu
    return "${diff.inDays} hari yang lalu";
  } else if (diff.inDays <= 30) {
    // Jika dalam satu bulan
    return "${(diff.inDays / 7).floor()} minggu yang lalu";
  } else if (diff.inDays <= 365) {
    // Jika dalam setahun
    return "${(diff.inDays / 30).floor()} bulan yang lalu";
  } else {
    // Jika lebih dari setahun
    return "${(diff.inDays / 365).floor()} tahun yang lalu";
  }
}
