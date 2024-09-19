import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFormLoginController extends GetxController {
  var isObscure = true.obs;
  var currentType = ''.obs;
  var formData = RxMap(
    {
      'email': {
        'text': '',
        'type': 'email',
        'controller': TextEditingController(),
      },
      'password': {
        'text': '',
        'type': 'password',
        'controller': TextEditingController(),
      },
      'emailRegister': {
        'text': '',
        'type': 'emailRegister',
        'controller': TextEditingController(),
      },
    },
  );

  void onChanged(String value, String type) {
    final currentController = formData[type]?['controller'];
    // Memperbarui referensi map
    formData[type] = {
      'text': value,
      'type': type,
      'controller': currentController!,
    };
    update();
  }

  void onTap(String type, bool isFocus) {
    final currentController = formData[type]?['controller'];
    final currentText = formData[type]?['text'];
    formData[type] = {
      'text': currentText!,
      'type': type,
      'controller': currentController!,
    };
    currentType.value = isFocus ? type : '';
    update();
  }

  void onClearController(String type) {
    final currentController = formData[type]?['controller'] as TextEditingController;
    currentController.clear();
    formData[type] = {
      'text': '',
      'type': type,
      'controller': currentController,
    };
    update();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  bool getIsEmailValid(String type) {
    final emailValue = formData[type]!['text'].toString();
    return EmailValidator.validate(emailValue);
  }

  bool getIsDataLoginValid() {
    final emailValue = formData['email']!['text'].toString();
    return EmailValidator.validate(emailValue) &&
        emailValue.isNotEmpty &&
        formData['password']!['text'].toString().isNotEmpty;
  }

  get isObscureValue => isObscure.value;
}
