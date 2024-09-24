import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/jwt_controller.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final jwtController = Get.put(JwtController());

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    await jwtController.checkToken();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
