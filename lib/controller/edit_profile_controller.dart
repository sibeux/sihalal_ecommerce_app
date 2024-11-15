import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;

  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();

  bool getIsNameNotValid() {
    final nameValue = name.value;
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  void setName(String value) {
    name.value = value;
    nameTextController.text = value;
  }

  void setEmail(String value) {
    email.value = value;
    emailTextController.text = value;
  }
}
