import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/auth_user_controller.dart';

class EmailLoginForm extends StatelessWidget {
  const EmailLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authLoginController = Get.put(AuthUserController());
    return FormBlueprint(
      authController: authLoginController,
      formType: 'email',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
    );
  }
}

class PasswordLoginForm extends StatelessWidget {
  const PasswordLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authPasswordController = Get.put(AuthPasswordController());
    return FormBlueprint(
      authController: authPasswordController,
      formType: 'password',
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.lock,
    );
  }
}

class FormBlueprint extends StatelessWidget {
  const FormBlueprint({
    super.key,
    required this.authController,
    required this.formType,
    required this.keyboardType,
    required this.icon,
  });

  final dynamic authController;
  final String formType;
  final TextInputType keyboardType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        controller: authController.controller,
        cursorColor: HexColor('#575757'),
        textAlignVertical: TextAlignVertical.center,
        keyboardType: keyboardType,
        obscureText:
            formType == 'password' ? authController.isObscureValue : false,
        onChanged: (value) {
          authController.onChanged(value);
        },
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: HexColor('#575757'),
          ),
          suffixIcon: formType == 'password'
              ? Obx(
                  () => authController.isObscureValue == false
                      ? GestureDetector(
                          onTap: () {
                            authController.toggleObscure();
                          },
                          child: Icon(
                            Icons.visibility_off,
                            color: HexColor('#575757'),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            authController.toggleObscure();
                          },
                          child: Icon(
                            Icons.visibility,
                            color: HexColor('#575757'),
                          ),
                        ),
                )
              : null,
          filled: true,
          isDense: true,
          fillColor: HexColor('#fefffe'),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 12,
          ),
          hintText: formType.capitalizeFirst!,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 45,
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 45,
          ),
          enabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: HexColor('#575757').withOpacity(0.5),
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(7),
    ),
  );
}

class LoginButtonEnable extends StatelessWidget {
  const LoginButtonEnable({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      authType: 'masuk',
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
  });

  final String authType;
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
            authType.capitalizeFirst!,
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
