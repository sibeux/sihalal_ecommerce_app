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
    final authLoginController = Get.put(AuthLoginController());
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
