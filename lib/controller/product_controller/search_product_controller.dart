import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
// http
import 'package:http/http.dart' as http;

class SearchProductController extends GetxController {
  var listProductSearch = RxList<Product>([]);

  final controller = TextEditingController();

  var textValue = ''.obs;

  var isTyping = false.obs;
  var isKeybordFocus = false.obs;
  var isSearch = false.obs;
  var isLoadingReadProduct = false.obs;

  void onChanged(String value) {
    isTyping.value = value.isNotEmpty;
    textValue.value = value;
    isKeybordFocus.value = true;
    controller.text = value;
    update();
  }

  void onClear() {
    isTyping.value = false;
    textValue.value = '';
    controller.clear();
  }

  void onRefresh(RefreshController controller) async {
    await Future.delayed(const Duration(milliseconds: 500));

    searchProduct();

    controller.refreshCompleted(resetFooterState: true);
  }

  void onLoading(RefreshController controller) async {
    controller.loadComplete();
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;

  Future<void> searchProduct() async {
    final String keyword = textValue.value;
    isLoadingReadProduct.value = true;

    final String url =
        'https://sibeux.my.id/project/sihalal/search?method=search_product&search=$keyword';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      var unescape = HtmlUnescape();

      if (listData.isNotEmpty) {
        final list = listData.map((produk) {
          return Product(
            uidProduct: produk['id_produk'],
            uidUser: produk['id_user'],
            uidShhalal: produk['id_shhalal'],
            nama: produk['nama_produk'] == null
                ? ''
                : unescape.convert(produk['nama_produk']),
            deskripsi: produk['deskripsi_produk'] == null
                ? ''
                : unescape.convert(produk['deskripsi_produk']),
            rating: produk['rating_produk'],
            harga: produk['harga_produk'],
            foto1: produk['foto_produk_1'],
            foto2: produk['foto_produk_2'],
            foto3: produk['foto_produk_3'],
            stok: produk['stok_produk'],
            berat: produk['berat_produk'],
            jumlahUlasan: produk['jumlah_ulasan'],
            jumlahRating: produk['jumlah_rating'],
            kota: produk['kota'],
            kategori: produk['kategori_shhalal'],
            merek: produk['merek_shhalal'],
            nomorHalal: produk['nomor_shhalal'],
            isFavorite: false,
          );
        }).toList();

        listProductSearch.value = list;
      } else {
        listProductSearch.value = [];
      }
    } catch (e) {
      debugPrint('Error in search_product: $e');
    } finally {
      isLoadingReadProduct.value = false;
    }
  }
}
