import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/persistent_bar_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/button_widgets.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/form_widgets.dart';

class RegisterEmailScreen extends StatelessWidget {
  const RegisterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userRegisterController = Get.put(UserRegisterController());
    final authController = Get.put(AuthFormController());
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(() => const PersistenBarScreen());
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            'Daftar SiHALAL',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorPalette().primary,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Daftar akun SiHALAL terlebih dahulu',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          const EmailRegisterForm(),
          Obx(
            () => userRegisterController.isEmailRegistered.value
                ? Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      '*Email ini sudah terdaftar',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red.withOpacity(1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 20),
          Obx(
            () => authController.getIsEmailValid('emailRegister')
                ? userRegisterController.isLoading.value
                    ? const AuthButtonLoading()
                    : const RegisterEmailEnable()
                : const AbsorbPointer(child: RegisterEmailDisable()),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sudah memiliki akun SiHALAL? ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  authController.onClearController('emailRegister');
                  Get.off(() => const LoginScreen());
                },
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette().primary,
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
