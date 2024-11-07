import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/shop.dart';

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
          deskripsiToko: shop['deskripsi_toko'] ?? '',
          kotaToko: shop['kota'],
          provinsiToko: shop['provinsi'],
          totalProduk: shop['total_produk'],
          totalRating: shop['rata_rata_rating'] ?? 0,
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