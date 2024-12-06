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

  var offset = 0;

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
    offset = 0;
  }

  void onRefresh(RefreshController controller) async {
    await Future.delayed(const Duration(milliseconds: 500));

    offset = 0;
    searchProduct(offset: offset);

    controller.refreshCompleted(resetFooterState: true);
  }

  void onLoading(RefreshController controller) async {
    if (offset != 0) {
      await searchProduct(offset: offset);
    }
    controller.loadComplete();
  }

  get getTextValue => textValue.value;

  get isTypingValue => isTyping.value;

  Future<void> searchProduct({required int offset}) async {
    final String keyword = textValue.value;
    if (offset == 0) {
      isLoadingReadProduct.value = true;
    }

    // mereset nilai this.offset setiap kali search
    this.offset = offset;

    final String url =
        'https://sibeux.my.id/project/sihalal/search?method=search_product&search=$keyword&offset=$offset';

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

        if (this.offset == 0) {
          listProductSearch.value = list;
        } else {
          listProductSearch.addAll(list);
        }
        this.offset += 10;
      } else {
        if (this.offset == 0) {
          // agar saat load more kirim data kosong, tidak blank putih
          listProductSearch.value = [];
        }
      }
    } catch (e) {
      debugPrint('Error in search_product: $e');
    } finally {
      isLoadingReadProduct.value = false;
    }
  }
}
