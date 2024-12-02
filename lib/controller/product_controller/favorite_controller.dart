import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';

class FavoriteController extends GetxController {
  var favoriteProduct = false.obs;
  var isLoadingFetchFavorite = false.obs;

  var listFavoriteProduct = RxList<Product>([]);

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

  Future<void> changeFavorite(
      {required String idProduk, required String method}) async {
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
        readFavorite();
      } else {
        debugPrint('Error Send Data: ${data['error']}');
      }
    } catch (e) {
      debugPrint('Error addFavorite: $e');
    }
  }

  Future<void> readFavorite() async {
    isLoadingFetchFavorite.value = true;

    final userProfileController = Get.find<UserProfileController>();

    // ** ini untuk menunggu idUser terisi
    await Future.doWhile(() async {
      if (userProfileController.idUser.isNotEmpty) return false;
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    });

    final idUser = userProfileController.idUser;

    final String url =
        "https://sibeux.my.id/project/sihalal/favorite?method=read&id_user=$idUser";
    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      final unescape = HtmlUnescape();

      if (listData.isNotEmpty) {
        final list = listData
            .map(
              (produk) => Product(
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
                isFavorite: produk['is_favorite'] == '1' ? true : false,
              ),
            )
            .toList();

            listFavoriteProduct.value = list;
      } else {
        listFavoriteProduct.value = [];
      }
    } catch (e) {
      debugPrint('Error fetch data in readFavorite(): $e');
    } finally {
      isLoadingFetchFavorite.value = false;
    }
  }
}
