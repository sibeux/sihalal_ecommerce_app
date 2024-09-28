import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/review.dart';
import 'package:sihalal_ecommerce_app/models/shop.dart';

class ProductDetailController extends GetxController {
  var imageIndex = 1.obs;
  var isShowAllDescription = false.obs;
  var useMaxLine = 5.obs;
  var useOverflow = RxList<TextOverflow>([TextOverflow.ellipsis]).obs;

  final shopInfoProductController = Get.put(ShopInfoProductController());
  final productReviewController = Get.put(ProductReviewController());

  void changeImageIndex(int index) {
    imageIndex.value = index;
  }

  void showAllDescription() {
    isShowAllDescription.value = true;
    useMaxLine.value = 100;
    useOverflow.value = RxList<TextOverflow>([TextOverflow.visible]);
  }

  void showLessDescription() {
    isShowAllDescription.value = false;
    useMaxLine.value = 5;
    useOverflow.value = RxList<TextOverflow>([TextOverflow.ellipsis]);
  }

  void getProductDetailData(String idProduk) {
    showLessDescription();
    shopInfoProductController.getShopInfo(idProduk);
    productReviewController.getProductReview(idProduk);
  }

  get maxLine => useMaxLine.value;
  get overflow => useOverflow.value;
}

class ShopInfoProductController extends GetxController {
  var isLoading = false.obs;
  var shopInfo = RxList<Shop?>([]);

  Future<void> getShopInfo(String idProduk) async {
    isLoading.value = true;

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=shop_info&id_produk=$idProduk';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      final list = listData.map((shop) {
        return Shop(
          idUser: shop['id_user'],
          fotoUser:
              regexGdriveLink(shop['foto_user'], apiData[0]['gdrive_api']),
          namaToko: shop['nama_toko'],
          deskripsiToko: shop['deskripsi_toko'],
          kotaToko: shop['kota'],
          provinsiToko: shop['provinsi'],
          totalProduk: shop['total_produk'],
          totalRating: shop['rata_rata_rating'],
        );
      }).toList();

      shopInfo.value = list;
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

class ProductReviewController extends GetxController {
  var isLoading = false.obs;
  var productReview = RxList<Review?>([]);

  Future<void> getProductReview(String idProduk) async {
    isLoading.value = true;

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=get_ulasan&id_produk=$idProduk';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      final list = listData.map((review) {
        return Review(
          idRating: review['id_rating'],
          idProduk: idProduk,
          idUser: review['id_user'],
          idPesanan: review['id_pesanan'],
          rating: review['bintang_rating'],
          ulasan: review['pesan_rating'] ?? '',
          tanggal: review['tanggal_rating'],
          namaUser: review['nama_user'],
          fotoUser: review['foto_user'] == null
              ? ''
              : regexGdriveLink(
                  review['foto_user'],
                  apiData[0]['gdrive_api'],
                ),
        );
      }).toList();

      productReview.value = list;
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
