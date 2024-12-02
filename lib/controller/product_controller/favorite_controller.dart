import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';

class FavoriteController extends GetxController {
  var favoriteProduct = false.obs;

  void changeFavoriteProduct({required String idProduk}) {
    favoriteProduct.value = !favoriteProduct.value;

    if (favoriteProduct.value) {
      changeFavorite(
        idProduk: idProduk,
        method: 'add',
      );
    } else {
      changeFavorite(
        idProduk: idProduk,
        method: 'delete',
      );
    }
  }

  Future<void> changeFavorite({required String idProduk, required String method}) async {
    const url = "https://sibeux.my.id/project/sihalal/favorite";

    final userProfileController = Get.find<UserProfileController>();

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'method': method,
          'id_produk': idProduk,
          'id_user': userProfileController.idUser,
        },
      );

      if (response.body.isEmpty) {
        debugPrint('Error Send Data: Response Body is Empty');
        return;
      }

      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        debugPrint('Success Send Data: ${data['status']}');
      } else {
        debugPrint('Error Send Data: ${data['error']}');
      }
    } catch (e) {
      debugPrint('Error addFavorite: $e');
    }
  }
}
