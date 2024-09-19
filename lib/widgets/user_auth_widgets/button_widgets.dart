import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/register_data_screen.dart';

class LoginSubmitButtonEnable extends StatelessWidget {
  const LoginSubmitButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'login',
      buttonText: 'Masuk',
      foreground: Colors.white,
      background: HexColor('#3f44a6'),
      isEnable: true,
      onPressed: () {},
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
    return AuthButton(
      authType: 'register',
      buttonText: 'Lanjutkan',
      foreground: Colors.white,
      background: HexColor('#3f44a6'),
      isEnable: true,
      onPressed: () {
        Get.to(
          () => const RegisterDataScreen(),
          transition: Transition.rightToLeftWithFade,
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
      authType: 'register',
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
    return AuthButton(
      authType: 'register',
      buttonText: 'Daftar',
      foreground: Colors.white,
      background: HexColor('#3f44a6'),
      isEnable: true,
      onPressed: () {},
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
