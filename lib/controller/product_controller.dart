
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  final controller = TextEditingController();
  var isTyping = false.obs;
  var textValue = ''.obs;
  var isKeybordFocus = false.obs;
  var isSearch = false.obs;

  void onChanged(String value) {
    isTyping.value = value.isNotEmpty;
    textValue.value = value;
    isKeybordFocus.value = true;
    filterProduct(value);
    update();
  }

  void filterProduct(String value) {
    isSearch.value = !isSearch.value;
    update();
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;
}
