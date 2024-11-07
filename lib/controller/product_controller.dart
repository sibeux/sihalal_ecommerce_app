import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/models/seller_product.dart';

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

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // ** tidak perlu await karena biar bisa dijalankan bersamaan
    getLeftProduct('recent');
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // ** ini untuk footer load more
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    refreshController.loadComplete();
  }

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
          uidUser: produk['id_user'],
          uidShhalal: produk['id_shhalal'],
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
          kota: produk['kota'],
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

class GetSellerProductController extends GetxController {
  var isGetProductLoading = false.obs;
  var needRefresh = false.obs;

  var sellerProductList = RxList<SellerProduct>([]);
  var visibleProductList = RxList<SellerProduct>([]);
  var invisibleProductList = RxList<SellerProduct>([]);
  var outStockProductList = RxList<SellerProduct>([]);

  var productVisible = 0.obs;
  var productInvisible = 0.obs;
  var productOutStock = 0.obs;
  var currentFilterProductList = 0.obs;

  void changeFilterProductList(int index) {
    currentFilterProductList.value = index;
    update();
  }

  void getProducts({required String email}) async {
    await getUserProduct(email: email);
  }

  Future<void> getUserProduct({required String email}) async {
    isGetProductLoading.value = true;

    productInvisible.value = 0;
    productVisible.value = 0;
    productOutStock.value = 0;

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=user_product&email=$email';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      if (listData.isNotEmpty) {
        final list = listData.map((produk) {
          if (produk['is_ditampilkan'] == 'true') {
            productVisible.value++;
          } else {
            productInvisible.value++;
          }
          if (produk['stok_produk'] == '0') {
            productOutStock.value++;
          }
          return SellerProduct(
            uidProduct: produk['id_produk'],
            uidUser: produk['id_user'],
            uidShhalal: produk['id_shhalal'],
            nama: produk['nama_produk'],
            deskripsi: produk['deskripsi_produk'] ?? '--',
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
            stok: produk['stok_produk'] ?? '0',
            berat: produk['berat_produk'] ?? '0',
            isVisible: produk['is_ditampilkan'] == 'true',
            countReview: produk['jumlah_ulasan'] ?? '0',
            kategori: produk['kategori_shhalal'],
            nomorSH: produk['nomor_shhalal'],
            merek: produk['merek_shhalal'],
          );
        }).toList();

        sellerProductList.value = list;
        visibleProductList.value =
            list.where((data) => data.isVisible).toList();
        invisibleProductList.value =
            list.where((data) => !data.isVisible).toList();
        outStockProductList.value =
            list.where((data) => data.stok == '0').toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isGetProductLoading.value = false;
      needRefresh.value = !needRefresh.value;
    }
  }
}
