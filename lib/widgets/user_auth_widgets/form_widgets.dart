import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';

class EmailLoginForm extends StatelessWidget {
  const EmailLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'email',
      formText: 'email',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      autoFillHints: AutofillHints.email,
    );
  }
}

class PasswordLoginForm extends StatelessWidget {
  const PasswordLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'password',
      formText: 'password',
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.lock,
      autoFillHints: '',
    );
  }
}

class EmailRegisterForm extends StatelessWidget {
  const EmailRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'emailRegister',
      formText: 'email',
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      autoFillHints: AutofillHints.email,
    );
  }
}

class NameRegisterForm extends StatelessWidget {
  const NameRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'nameRegister',
      formText: 'nama lengkap',
      keyboardType: TextInputType.text,
      icon: Icons.person,
      autoFillHints: AutofillHints.name,
    );
  }
}

class PasswordRegisterForm extends StatelessWidget {
  const PasswordRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'passwordRegister',
      formText: 'password',
      keyboardType: TextInputType.visiblePassword,
      icon: Icons.lock,
      autoFillHints: '',
    );
  }
}

class FormBlueprint extends StatelessWidget {
  const FormBlueprint({
    super.key,
    required this.formType,
    required this.keyboardType,
    required this.icon,
    required this.formText,
    required this.autoFillHints,
  });

  final String formType, formText, autoFillHints;
  final TextInputType keyboardType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final authFormController = Get.put(AuthFormController());
    final controller = authFormController.formData[formType]?['controller'];
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: controller as TextEditingController?,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          enableSuggestions: true,
          autofillHints: [autoFillHints],
          keyboardType: keyboardType,
          obscureText: formType.toLowerCase().contains('password')
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
            suffixIcon: formType.toLowerCase().contains('password')
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
            hintText: formText.capitalize,
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
    AuthFormController authController, String formType) {
  final textValue = authController.formData[formType]?['text'].toString();
  final isCurrentType = authController.currentType.value == formType;
  final userRegisterController = Get.put(UserRegisterController());

  return OutlineInputBorder(
    borderSide: BorderSide(
      color: (isCurrentType || textValue!.isNotEmpty)
          ? formType.toLowerCase().contains('email')
              ? !authController.getIsEmailValid(formType) &&
                      textValue!.isNotEmpty
                  ? HexColor('#ff0000').withOpacity(0.5)
                  : userRegisterController.isEmailRegistered.value
                      ? HexColor('#ff0000').withOpacity(0.5)
                      : ColorPalette().primary.withOpacity(0.5)
              : formType.toLowerCase().contains('name')
                  ? authController.getIsNameValid() && textValue!.isNotEmpty
                      ? HexColor('#ff0000').withOpacity(0.5)
                      : ColorPalette().primary.withOpacity(0.5)
                  : ColorPalette().primary.withOpacity(0.5)
          : HexColor('#575757').withOpacity(0.5),
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(7),
    ),
  );
}
