import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/cart.dart';

class CartController extends GetxController {
  var isLoadingReadCart = false.obs;
  var isLoadingRedirectToCheckoutScreen = false.obs;

  var quantity = RxMap<String, int>();
  var productStock = RxMap<String, int>();

  var listCart = RxList<Cart>([]);

  void increment({required String keyQty, required String keyStock}) {
    if (quantity[keyQty]! < 99 && quantity[keyQty]! < productStock[keyStock]!) {
      quantity[keyQty] = quantity[keyQty]! + 1;
      quantity.refresh();
    }
  }

  void decrement({required String keyQty}) {
    if (quantity[keyQty]! > 1) {
      quantity.update(keyQty, (value) => value - 1);
    } else {
      changeCart(
        method: 'delete',
        idProduk:
            listCart.firstWhere((element) => element.idCart == keyQty).idProduk,
        idCart: keyQty,
      );
    }
  }

  Future<void> changeCart({
    required String method,
    required String idProduk,
    required String idCart,
  }) async {
    const String url = 'https://sibeux.my.id/project/sihalal/cart';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': method,
          'id_produk': idProduk,
          'id_user': Get.find<UserProfileController>().idUser,
          'id_cart': idCart,
        },
      );

      if (response.body.isEmpty) {
        debugPrint('Error Send Data: Response Body is Empty');
        return;
      }

      final data = json.decode(response.body);

      if (data['status'] == 'success') {
        if (method == 'add') {
          Get.snackbar(
            'Berhasil',
            'Produk telah ditambahkan ke keranjang',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }
        debugPrint('Success Send Data: ${data['status']}');
        readCart();
      } else {
        debugPrint('Error Send Data: ${data['error']}');
      }
    } catch (e) {
      debugPrint('Error add Data in addCart(): $e');
    }
  }

  Future<void> readCart() async {
    isLoadingReadCart.value = true;

    // ** ini untuk menunggu idUser terisi
    await Future.doWhile(() async {
      if (Get.find<UserProfileController>().idUser.isNotEmpty) return false;
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    });

    final String idUser = Get.find<UserProfileController>().idUser;

    final String url =
        'https://sibeux.my.id/project/sihalal/cart?method=read&id_user=$idUser';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);
      var unescape = HtmlUnescape();

      if (listData.isNotEmpty) {
        final list = listData
            .map(
              (cart) => Cart(
                idCart: cart['id_keranjang'],
                idProduk: cart['id_produk'],
                idUser: cart['id_user'],
                stokProduk: int.parse(cart['stok_produk']),
                hargaProduk: int.parse(cart['harga_produk']),
                fotoProduk: cart['foto_produk_1'],
                namaProduk: unescape.convert(cart['nama_produk']),
              ),
            )
            .toList();

        listCart.value = list;
      } else {
        listCart.value = [];
      }
    } catch (e) {
      debugPrint('Error read Data in readCart(): $e');
    } finally {
      isLoadingReadCart.value = false;
    }
  }
}
