import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:http/http.dart' as http;

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

class GetScrollLeftProductController extends GetxController {
  var recentProduct = RxList<Product?>([]);
  var isLoading = false.obs;

  Future<void> getLeftProduct(String sort) async {
    isLoading.value = true;

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=scroll_left&sort=$sort';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      final list = listData.map((produk) {
        return Product(
          uidProduct: produk['id_produk'],
          uidKategori: produk['id_kategori'],
          uidUser: produk['id_user'],
          nama: produk['nama_produk'],
          deskripsi: produk['deskripsi_produk'] ?? '--',
          rating: produk['rating_produk'],
          harga: produk['harga_produk'],
          foto1: regexGdriveLink(
              produk['foto_produk_1'], apiData[0]['gdrive_api']),
          foto2: produk['foto_produk_2'] == null
              ? ''
              : regexGdriveLink(
                  produk['foto_produk_2'], apiData[0]['gdrive_api']),
          foto3: produk['foto_produk_3'] == null
              ? ''
              : regexGdriveLink(
                  produk['foto_produk_3'], apiData[0]['gdrive_api']),
          stok: produk['stok_produk'],
          jumlahUlasan: produk['jumlah_ulasan'],
          jumlahRating: produk['jumlah_rating'],
        );
      }).toList();

      recentProduct.value = list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      // ini tetap dieksekusi baik berhasil atau gagal
      isLoading.value = false;
    }
  }
}
