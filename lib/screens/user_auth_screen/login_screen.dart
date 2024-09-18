import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/auth_user_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/button_widgets.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/form_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authPasswordController = Get.put(AuthPasswordController());
    final authUserController = Get.put(AuthUserController());
    return Scaffold(
      backgroundColor: HexColor('fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('fefffe'),
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
          Obx(
            () => authPasswordController.isObscureValue
                ? const PasswordLoginForm()
                : const PasswordLoginForm(),
          ),
          const SizedBox(height: 30),
          Obx(
            () => authUserController.isEmailValid &&
                    authPasswordController.getTextValue.isNotEmpty
                ? const LoginButtonEnable()
                : const AbsorbPointer(child: LoginButtonDisable()),
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
                onTap: () {},
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
