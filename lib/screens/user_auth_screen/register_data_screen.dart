import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/button_widgets.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/form_widgets.dart';

class RegisterDataScreen extends StatelessWidget {
  const RegisterDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthFormController());
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
      ),
      body: Column(
        children: [
          Text(
            'Data Diri',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: HexColor('#3f44a6'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Mohon lengkapi data diri anda',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),
          const NameRegisterForm(),
          const SizedBox(height: 5),
          Obx(
            () => authController.getIsNameValid()
                ? Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      '*Nama tidak boleh mengandung angka atau simbol',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red.withOpacity(1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: 10),
          const PasswordRegisterForm(),
          const SizedBox(height: 20),
          Obx(
            () => authController.getIsDataRegisterValid() &&
                    !authController.getIsNameValid()
                ? const RegisterSubmitButtonEnable()
                : const AbsorbPointer(child: RegisterSubmitButtonDisable()),
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
                  authController.onClearController('nameRegister');
                  authController.onClearController('passwordRegister');
                  Get.to(() => const LoginScreen());
                },
                child: Text(
                  'Masuk',
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
