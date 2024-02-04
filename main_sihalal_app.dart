import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/screens/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

var kPrimaryColor = const Color.fromARGB(255, 61, 195, 163);

final theme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.montserratAlternatesTextTheme(),
    colorSchemeSeed: kPrimaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor));

class MainSihalalApp extends StatelessWidget {
  const MainSihalalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
      ),
    );
    return MaterialApp(
      theme: theme,
      home: const DashboardScreen(),
    );
  }
}
