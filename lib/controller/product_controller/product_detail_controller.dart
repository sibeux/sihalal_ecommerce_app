import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_info_product_controller.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/models/product.dart';

class ProductDetailController extends GetxController {
  var imageIndex = 1.obs;
  var useMaxLine = 5.obs;
  var stockProduct = 0.obs;
  var imageProductCount = 1.obs;

  var useOverflow = RxList<TextOverflow>([TextOverflow.ellipsis]).obs;
  var listImageProduct = RxList<String>([]);
  var productDetailData = RxList<Product>([]);

  var isShowAllDescription = false.obs;
  var isLoadingFetchDataProduct = false.obs;

  final shopInfoProductController = Get.find<ShopInfoProductController>();
  final productReviewController = Get.put(ProductReviewController());

  late String idProduk, fotoImage1;

  ProductDetailController({required this.idProduk, required this.fotoImage1});

  @override
  void onInit() async {
    listImageProduct.value = [fotoImage1];
    await fetchDataProductDetail(idProduk: idProduk);
    super.onInit();
  }

  @override
  void onClose() {
    shopInfoProductController.needMoveScreen.value = false;
    super.onClose();
  }

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

  Future<void> fetchDataProductDetail({required String idProduk}) async {
    isLoadingFetchDataProduct.value = true;

    getProductDetailData(idProduk);

    final String url =
        'https://sibeux.my.id/project/sihalal/product?method=get_product_detail&id_produk=$idProduk';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      var unescape = HtmlUnescape();

      if (listData.isNotEmpty) {
        final list = listData.map((product) {
          imageProductCount.value = product['foto_produk_3'] != ""
              ? 3
              : product['foto_produk_2'] != ""
                  ? 2
                  : 1;
          stockProduct.value = int.parse(product['stok_produk']);
          return Product(
            uidProduct: product['id_produk'],
            uidUser: product['id_user'],
            uidShhalal: product['id_shhalal'],
            foto1: product['foto_produk_1'],
            foto2: product['foto_produk_2'],
            foto3: product['foto_produk_3'],
            nama: unescape.convert(product['nama_produk']),
            deskripsi: unescape.convert(product['deskripsi_produk']),
            harga: product['harga_produk'],
            rating: product['rating_produk'],
            stok: product['stok_produk'],
            berat: product['berat_produk'],
            jumlahUlasan: product['jumlah_ulasan'],
            jumlahRating: product['jumlah_rating'],
            kota: product['kota'],
            kategori: product['kategori_shhalal'],
            merek: product['merek_shhalal'],
            nomorHalal: product['nomor_shhalal'],
          );
        }).toList();

        listImageProduct.value = [
          list[0].foto1,
          list[0].foto2,
          list[0].foto3,
        ];

        productDetailData.value = list;
      } else {
        productDetailData.value = [];
      }
    } catch (e) {
      debugPrint('Error Fetch Data: $e');
    } finally {
      isLoadingFetchDataProduct.value = false;
    }
  }

  get maxLine => useMaxLine.value;
  get overflow => useOverflow.value;
}
