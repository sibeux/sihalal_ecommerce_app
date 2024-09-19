import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/auth_form_controller.dart';

class EmailLoginForm extends StatelessWidget {
  const EmailLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authFormController = Get.put(AuthFormLoginController());
    return FormBlueprint(
      authFormController: authFormController,
      formType: 'email',
      formText: 'email',
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
    final authFormController = Get.put(AuthFormLoginController());
    return FormBlueprint(
      authFormController: authFormController,
      formType: 'password',
      formText: 'password',
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.lock,
    );
  }
}

class EmailRegisterForm extends StatelessWidget {
  const EmailRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final authFormController = Get.put(AuthFormLoginController());
    return FormBlueprint(
      authFormController: authFormController,
      formType: 'emailRegister',
      formText: 'email',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
    );
  }
}

class FormBlueprint extends StatelessWidget {
  const FormBlueprint({
    super.key,
    required this.authFormController,
    required this.formType,
    required this.keyboardType,
    required this.icon,
    required this.formText,
  });

  final AuthFormLoginController authFormController;
  final String formType, formText;
  final TextInputType keyboardType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final controller = authFormController.formData[formType]?['controller'];
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: controller as TextEditingController?,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          obscureText: formType.contains('password')
              ? authFormController.isObscureValue
              : false,
          onChanged: (value) {
            authFormController.onChanged(value, formType);
          },
          onTap: () {
            authFormController.onTap(formType, true);
          },
          onTapOutside: (event) {
            authFormController.onTap(formType, false);
            FocusManager.instance.primaryFocus?.unfocus();
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
            suffixIcon: formType.contains('password')
                ? Obx(
                    () => authFormController.isObscureValue == false
                        ? GestureDetector(
                            onTap: () {
                              authFormController.toggleObscure();
                            },
                            child: Icon(
                              Icons.visibility_off,
                              color: HexColor('#575757'),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              authFormController.toggleObscure();
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
            hintText: formText.capitalizeFirst!,
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
            enabledBorder: outlineInputBorder(authFormController, formType),
            focusedBorder: outlineInputBorder(authFormController, formType),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(
    AuthFormLoginController authController, String formType) {
  final textValue = authController.formData[formType]?['text'].toString();
  final isCurrentType = authController.currentType.value == formType;

  return OutlineInputBorder(
    borderSide: BorderSide(
      color: (isCurrentType || textValue!.isNotEmpty)
          ? formType.contains('email')
              ? !authController.getIsEmailValid(formType) &&
                      textValue!.isNotEmpty
                  ? HexColor('#ff0000').withOpacity(0.5)
                  : HexColor('#3f44a6').withOpacity(0.5)
              : HexColor('#3f44a6').withOpacity(0.5)
          : HexColor('#575757').withOpacity(0.5),
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(7),
    ),
  );
}
