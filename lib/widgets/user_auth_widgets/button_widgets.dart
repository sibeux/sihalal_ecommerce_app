import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginButtonEnable extends StatelessWidget {
  const LoginButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'masuk',
      buttonText: 'Masuk',
      foreground: Colors.white,
      background: HexColor('#3f44a6'),
      isEnable: true,
    );
  }
}

class LoginButtonDisable extends StatelessWidget {
  const LoginButtonDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'masuk',
      buttonText: 'Masuk',
      foreground: HexColor('#a8b5c8'),
      background: HexColor('#e5eaf5'),
      isEnable: false,
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
  });

  final String authType, buttonText;
  final Color foreground, background;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        onPressed: () {
          if (isEnable) {
            // Do something
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
