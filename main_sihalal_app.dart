import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/screens/dashboard.dart';

var kPrimaryColor = const Color.fromARGB(255, 185, 235, 178);

class MainSihalalApp extends StatelessWidget {
  const MainSihalalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return const MaterialApp(
      home: DashboardScreen(),
    );
  }
}
