import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';

class GetScrollProductController extends GetxController {
  var recentProduct = RxList<Product?>([]);
  var leftRandomProduct = RxList<Product?>([]);
  var verticalRecentProduct = RxList<Product?>([]);

  var isLoadingRecent = false.obs;
  var isLoadingLeftRandom = false.obs;
  var isLoadingVerticalRecent = false.obs;
  var isLoadNoData = false.obs;

  var offset = 0;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // ** tidak perlu await karena biar bisa dijalankan bersamaan
    offset = 0;
    getProduct('recent');
    getProduct('random', isVertical: false);
    getProduct('recent', isVertical: true);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted(resetFooterState: true);
  }

  void onLoading() async {
    // ** ini untuk footer load more
    if (offset != 0) {
      await getProduct('recent',
          isVertical: true, isLoadMore: true, offset: offset);
    }
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (isLoadNoData.value) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
  }

  Future<void> getProduct(
    String sort, {
    bool isVertical = false,
    bool isLoadMore = false,
    int offset = 0,
  }) async {
    if (sort == 'recent' && !isVertical && !isLoadMore) {
      isLoadingRecent.value = true;
    } else if (sort == 'random' && !isVertical && !isLoadMore) {
      isLoadingLeftRandom.value = true;
    } else if (sort == 'recent' && isVertical && !isLoadMore) {
      isLoadingVerticalRecent.value = true;
    }

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=scroll_left&sort=$sort&offset=$offset';
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

      if (sort == 'recent' && !isVertical && !isLoadMore) {
        recentProduct.value = list;
      } else if (sort == 'random' && !isVertical && !isLoadMore) {
        leftRandomProduct.value = list;
      } else if (sort == 'recent' && isVertical && !isLoadMore) {
        this.offset += 10;
        list.shuffle();
        verticalRecentProduct.value = list;
      } else if (sort == 'recent' && isVertical && isLoadMore) {
        if (list.isNotEmpty) {
          this.offset += 10;
          list.shuffle();
          verticalRecentProduct.addAll(
            list.where(
              (produk) => !verticalRecentProduct.any((existingProduk) =>
                  existingProduk!.uidProduct == produk.uidProduct),
            ),
          );
        } else {
          isLoadNoData.value = true;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      // ini tetap dieksekusi baik berhasil atau gagal
      if (sort == 'recent' && !isVertical && !isLoadMore) {
        isLoadingRecent.value = false;
      } else if (sort == 'random' && !isVertical && !isLoadMore) {
        isLoadingLeftRandom.value = false;
      } else if (sort == 'recent' && isVertical && !isLoadMore) {
        isLoadingVerticalRecent.value = false;
      }
    }
  }
}
