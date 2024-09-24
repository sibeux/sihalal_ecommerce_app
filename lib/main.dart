import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sihalal_ecommerce_app/screens/splash_screen/splash_screen.dart';

final theme = ThemeData(
  fontFamily: 'SauceOne',
);

void main() async {
  // debugPaintSizeEnabled = true; // Mengaktifkan debug paint
  await GetStorage.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((fn) {
    runApp(const ProviderScope(child: MyApp()));
  });
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
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
      ],
      builder: (context, child) {
        // create multiple builders
        child = FToastBuilder()(context, child);
        return child;
      },
    );
  }
}
