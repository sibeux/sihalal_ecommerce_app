import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sihalal_ecommerce_app/screens/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

var kPrimaryColor = const Color.fromARGB(
  255,
  97,
  186,
  99,
);

final theme = ThemeData(
  fontFamily: GoogleFonts.lato().fontFamily,
);

void main() {
  runApp(const MainSihalalApp());
}

class MainSihalalApp extends StatelessWidget {
  const MainSihalalApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      theme: theme,
      home: const DashboardScreen(),
    );
  }
}
