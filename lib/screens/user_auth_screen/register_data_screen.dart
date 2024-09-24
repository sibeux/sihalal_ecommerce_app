import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/button_widgets.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/form_widgets.dart';

class RegisterDataScreen extends StatelessWidget {
  const RegisterDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthFormController());
    final userRegisterController = Get.put(UserRegisterController());
    final String email = Get.arguments['email'] ?? '';
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#fefffe'),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: HexColor('#fefffe'),
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
            ),
            title: const Text('Daftar'),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                'Data Diri',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette().primary,
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
                    ? userRegisterController.isLoading.value
                        ? const AuthButtonLoading()
                        : RegisterSubmitButtonEnable(email: email)
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
                      Get.off(
                        () => const LoginScreen(),
                        fullscreenDialog: true,
                        popGesture: false,
                      );
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
        ),
        Obx(() => userRegisterController.isRedirecting.value
            ? const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              )
            : const SizedBox()),
        Obx(() => userRegisterController.isRedirecting.value
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 50,
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}
