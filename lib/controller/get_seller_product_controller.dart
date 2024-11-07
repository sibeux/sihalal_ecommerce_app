import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/seller_product.dart';

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
