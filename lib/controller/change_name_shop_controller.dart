import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// http
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';

class ChangeNameShopController extends GetxController {
  final controller = TextEditingController();

  var textValue = ''.obs;

  var isTyping = false.obs;
  var isKeybordFocus = false.obs;
  var isSearch = false.obs;
  var isLoadingChangeNameShop = false.obs;

  void onTyping(String value) {
    isTyping.value = value.isNotEmpty;
    update();
  }

  void onChanged(String value) {
    isTyping.value = value.isNotEmpty;
    textValue.value = value;
    isKeybordFocus.value = true;
    update();
  }

  Future<void> changeNameShop() async {
    isLoadingChangeNameShop.value = true;
    const String url = 'https://sibeux.my.id/project/sihalal/seller/shop';

    try {
      final box = GetStorage();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'change_name_shop',
          'email': box.read('email'),
          'name_shop': textValue.value,
        },
      );

      if (response.body.isEmpty) {
        debugPrint('Error Send Data: Response Body is Empty');
        return;
      }

      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        debugPrint(
            'Success Send Data in changeNameShopController: ${data['status']}');
        await Get.find<UserProfileController>().getUserData();
      } else {
        debugPrint(
            'Error Send Data in changeNameShopController: ${data['error']}');
      }
    } catch (e) {
      debugPrint('Error add Data in changeNameShopController: $e');
    } finally {
      isLoadingChangeNameShop.value = false;
    }
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;
}
