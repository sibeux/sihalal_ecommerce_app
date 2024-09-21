import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/user.dart';

class ProductDetailController extends GetxController {
  var imageIndex = 1.obs;
  var isShowAllDescription = false.obs;
  var useMaxLine = 5.obs;
  var useOverflow = RxList<TextOverflow>([TextOverflow.ellipsis]).obs;

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

  get maxLine => useMaxLine.value;
  get overflow => useOverflow.value;
}

class ShopInfoProductController extends GetxController {
  var isLoading = false.obs;
  var shopInfo = RxList<User?>([]);

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

      final list = listData.map((user) {
        return User(
          idUser: user['id_user'],
          idAlamat: user['id_alamat'],
          namaUser: user['nama_user'],
          emailUser: user['email_user'],
          passuser: user['pass_user'],
          fotoUser:
              regexGdriveLink(user['foto_user'], apiData[0]['gdrive_api']),
          namaToko: user['nama_toko'],
          deskripsiToko: user['deskripsi_toko'],
          kotaToko: user['kota'],
          provinsiToko: user['provinsi'],
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
