import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/account_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/register_email_screen.dart';

class CheckValidLoginScreen extends StatelessWidget {
  const CheckValidLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final login = box.read('login') == true;
    if (login) {
      return const AccountScreen();
    } else {
      return const UserAuthOptionScreen();
    }
  }
}

class UserAuthOptionScreen extends StatelessWidget {
  const UserAuthOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const LoginScreen());
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const RegisterEmailScreen());
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
