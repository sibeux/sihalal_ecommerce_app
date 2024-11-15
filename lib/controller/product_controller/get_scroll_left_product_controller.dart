import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';

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

    var unescape = HtmlUnescape();

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
          nama: produk['nama_produk'] == null
              ? ''
              : unescape.convert(produk['nama_produk']),
          deskripsi: produk['deskripsi_produk'] == null
              ? ''
              : unescape.convert(produk['deskripsi_produk']),
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
          berat: produk['berat_produk'],
          jumlahUlasan: produk['jumlah_ulasan'],
          jumlahRating: produk['jumlah_rating'],
          kota: produk['kota'],
          kategori: produk['kategori_shhalal'],
          merek: produk['merek_shhalal'],
          nomorHalal: produk['nomor_shhalal'],
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
