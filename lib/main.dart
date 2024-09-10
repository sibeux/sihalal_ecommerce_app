import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/home_screen.dart';

var kPrimaryColor = const Color.fromARGB(
  255,
  97,
  186,
  99,
);

final theme = ThemeData(
  fontFamily: GoogleFonts.roboto().fontFamily,
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
    );
    return GetMaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      title: 'SiHALAL',
      home: const HomeScreen(),
    );
  }
}
