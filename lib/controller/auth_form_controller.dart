import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthFormLoginController extends GetxController {
  var isObscure = true.obs;

  var formData = RxMap(
    {
      'email': {
        'text': '',
        'type': 'email',
        'isKeybordFocus': false,
        'controller': TextEditingController(),
      },
      'password': {
        'text': '',
        'type': 'password',
        'isKeybordFocus': false,
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
      'isKeybordFocus': true,
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
      'isKeybordFocus': isFocus,
      'controller': currentController!,
    };
    update();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  get getEmailValue => formData['email']?['text'];

  get getPasswordValue => formData['password']?['text'];

  get isEmailValid => EmailValidator.validate(getEmailValue);

  get isAllDataValid =>
      isEmailValid && getEmailValue.isNotEmpty && getPasswordValue.isNotEmpty;

  get isObscureValue => isObscure.value;
}