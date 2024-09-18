import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthUserController extends GetxController {
  final controller = TextEditingController();
  var isTyping = false.obs;
  var textValue = ''.obs;
  var isKeybordFocus = false.obs;

  void onChanged(String value) {
    isTyping.value = value.isNotEmpty;
    textValue.value = value;
    isKeybordFocus.value = true;
    update();
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;

  get isEmailValid => EmailValidator.validate(textValue.value);
}

class AuthPasswordController extends GetxController {
  final controller = TextEditingController();
  var isTyping = false.obs;
  var textValue = ''.obs;
  var isKeybordFocus = false.obs;
  var isObscure = true.obs;

  void onChanged(String value) {
    isTyping.value = value.isNotEmpty;
    textValue.value = value;
    isKeybordFocus.value = true;
    update();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;

  get isObscureValue => isObscure.value;
}
