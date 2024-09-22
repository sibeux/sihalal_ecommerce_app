import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/register_email_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/button_widgets.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/form_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthFormLoginController());
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => const HomeScreen());
          },
        ),
        backgroundColor: HexColor('#fefffe'),
      ),
      body: Column(
        children: [
          Text(
            'Masuk Sekarang',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor('#3f44a6'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Mohon masuk ke dalam akun anda',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          const EmailLoginForm(),
          const SizedBox(height: 10),
          const PasswordLoginForm(),
          const SizedBox(height: 30),
          Obx(
            () => authController.getIsDataLoginValid()
                ? const LoginSubmitButtonEnable()
                : const AbsorbPointer(child: LoginSubmitButtonDisable()),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Belum memiliki akun SiHALAL? ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  authController.onClearController('email');
                  authController.onClearController('password');
                  Get.to(() => const RegisterEmailScreen());
                },
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 12,
                    color: HexColor('#3f44a6'),
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
