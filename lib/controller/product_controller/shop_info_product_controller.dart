import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/shop.dart';

class ShopInfoProductController extends GetxController {
  var isLoading = false.obs;
  var shopInfo = RxList<Shop?>([]);
  var needAwait = false.obs;

  Future<void> getShopInfo(String idProduk) async {
    isLoading.value = true;
    var unescape = HtmlUnescape();

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=shop_info&id_produk=$idProduk';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      if (listData.isNotEmpty) {
        final list = listData.map((shop) {
          return Shop(
            idUser: shop['id_user'],
            fotoUser: shop['foto_user'] == null
                ? ''
                : regexGdriveLink(shop['foto_user'], apiData[0]['gdrive_api']),
            namaToko: shop['nama_toko'] == null
                ? 'Toko ${shop['nama_user']}'
                : unescape.convert(shop['nama_toko']),
            deskripsiToko: shop['deskripsi_toko'] == null
                ? ''
                : unescape.convert(shop['deskripsi_toko']),
            kotaToko: shop['kota'],
            provinsiToko: shop['provinsi'],
            totalProduk: shop['total_produk'],
            totalRating: shop['rata_rata_rating'] ?? '0',
          );
        }).toList();

        shopInfo.value = list;
      } else {
        shopInfo.value = [];
        Get.back();
        Fluttertoast.showToast(
          msg: 'Tampaknya produk telah dihapus',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(1),
          textColor: Colors.white,
          fontSize: 10.0,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      // ini tetap dieksekusi baik berhasil atau gagal
      isLoading.value = false;
      needAwait.value = false;
    }
  }
}
