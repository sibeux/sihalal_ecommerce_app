import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/screens/dashboard.dart';
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

class MainSihalalApp extends StatelessWidget {
  const MainSihalalApp({Key? key}) : super(key: key);

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
