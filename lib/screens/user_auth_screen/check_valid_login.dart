import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/account_screen.dart';

class CheckValidLoginScreen extends StatelessWidget {
  const CheckValidLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final login = box.read('login');

    return AccountScreen(login: login);
  }
}
