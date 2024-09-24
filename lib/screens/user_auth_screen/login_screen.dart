import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/register_email_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/button_widgets.dart';
import 'package:sihalal_ecommerce_app/widgets/user_auth_widgets/form_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthFormController());
    final userLoginController = Get.put(UserLoginController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#fefffe'),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
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
                  color: ColorPalette().primary,
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
              Obx(
                () => !userLoginController.isLoginSuccess.value
                    ? Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          '*Email atau password tidak sesuai',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red.withOpacity(1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              const SizedBox(height: 30),
              Obx(
                () => authController.getIsDataLoginValid()
                    ? userLoginController.isLoading.value
                        ? const AuthButtonLoading()
                        : const LoginSubmitButtonEnable()
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
                      authController.onClearController('emailLogin');
                      authController.onClearController('passwordLogin');
                      authController.onClearController('emailRegister');
                      Get.off(() => const RegisterEmailScreen());
                    },
                    child: Text(
                      'Daftar',
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
        Obx(() => userLoginController.isRedirecting.value
            ? const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              )
            : const SizedBox()),
        Obx(() => userLoginController.isRedirecting.value
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
