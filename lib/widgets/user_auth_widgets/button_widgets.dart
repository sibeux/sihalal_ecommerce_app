import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';

class LoginSubmitButtonEnable extends StatelessWidget {
  const LoginSubmitButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final UserLoginController userLoginController =
        Get.put(UserLoginController());
    final AuthFormController authController = Get.put(AuthFormController());
    return AuthButton(
      authType: 'login',
      buttonText: 'Masuk',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        userLoginController.generateJwtLogin(
          email: authController.formData['emailLogin']!['text'].toString(),
          password:
              authController.formData['passwordLogin']!['text'].toString(),
        );
      },
    );
  }
}

class LoginSubmitButtonDisable extends StatelessWidget {
  const LoginSubmitButtonDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'login',
      buttonText: 'Masuk',
      foreground: HexColor('#a8b5c8'),
      background: HexColor('#e5eaf5'),
      isEnable: false,
      onPressed: () {},
    );
  }
}

class RegisterEmailEnable extends StatelessWidget {
  const RegisterEmailEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final userRegisterController = Get.put(UserRegisterController());
    final authController = Get.put(AuthFormController());
    return AuthButton(
      authType: 'emailRegister',
      buttonText: 'Lanjutkan',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        authController.onClearController('nameRegister');
        authController.onClearController('passwordRegister');
        userRegisterController.getCheckEmail(
          email: authController.formData['emailRegister']!['text'].toString(),
        );
      },
    );
  }
}

class RegisterEmailDisable extends StatelessWidget {
  const RegisterEmailDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'emailRegister',
      buttonText: 'lanjutkan',
      foreground: HexColor('#a8b5c8'),
      background: HexColor('#e5eaf5'),
      isEnable: false,
      onPressed: () {},
    );
  }
}

class RegisterSubmitButtonEnable extends StatelessWidget {
  const RegisterSubmitButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final userRegisterController = Get.put(UserRegisterController());
    final authController = Get.put(AuthFormController());

    return AuthButton(
      authType: 'register',
      buttonText: 'Daftar',
      foreground: Colors.white,
      background: ColorPalette().primary,
      isEnable: true,
      onPressed: () {
        userRegisterController.createNewUserData(
          email: authController.formData['emailRegister']!['text'].toString(),
          name: authController.formData['nameRegister']!['text']
              .toString()
              .trim(),
          password:
              authController.formData['passwordRegister']!['text'].toString(),
        );
      },
    );
  }
}

class RegisterSubmitButtonDisable extends StatelessWidget {
  const RegisterSubmitButtonDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'register',
      buttonText: 'Daftar',
      foreground: HexColor('#a8b5c8'),
      background: HexColor('#e5eaf5'),
      isEnable: false,
      onPressed: () {},
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.authType,
    required this.foreground,
    required this.background,
    required this.isEnable,
    required this.buttonText,
    required this.onPressed,
  });

  final String authType, buttonText;
  final Color foreground, background;
  final bool isEnable;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          if (isEnable) {
            onPressed();
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: foreground,
          backgroundColor: background,
          elevation: 0, // Menghilangkan shadow
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(
            double.infinity,
            40,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
          ),
          child: Text(
            buttonText.capitalizeFirst!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButtonLoading extends StatelessWidget {
  const AuthButtonLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          // Do nothing
        },
        style: ElevatedButton.styleFrom(
          elevation: 0, // Menghilangkan shadow
          backgroundColor: HexColor('#fefffe'),
          splashFactory: InkRipple.splashFactory,
          side: BorderSide(
            color: ColorPalette().primary,
            strokeAlign: BorderSide.strokeAlignCenter,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(
            double.infinity,
            40,
          ),
        ),
        child: Center(
          child: Transform.scale(
            scale: 0.7,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorPalette().primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
