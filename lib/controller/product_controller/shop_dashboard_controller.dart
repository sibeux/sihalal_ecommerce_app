import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';

import 'package:http/http.dart' as http;

class ShopDashboardController extends GetxController {
  var isLoadingGetProductMostSold = false.obs;
  var isLoadingGetAllProduct = false.obs;

  var listProductMostSold = RxList<Product>([]);
  var listAllProduct = RxList<Product>([]);

  void fetchProductNow({required String idUSer}) {
    getProductShopDashboard(method: 'most_sold', idUser: idUSer);
    getProductShopDashboard(
        method: 'all_product_shop_dashboard', idUser: idUSer);
  }

  Future<void> getProductShopDashboard({
    required String method,
    required String idUser,
  }) async {
    if (method == 'most_sold') {
      isLoadingGetProductMostSold.value = true;
    } else {
      isLoadingGetAllProduct.value = true;
    }

    final url =
        'https://sibeux.my.id/project/sihalal/product?method=$method&id_user=$idUser';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      var unescape = HtmlUnescape();

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
                foto2: produk['foto_produk_2'] ?? '',
                foto3: produk['foto_produk_3'] ?? '',
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

        if (method == 'most_sold') {
          listProductMostSold.value = list;
        } else {
          listAllProduct.value = list;
        }
      } else {
        if (method == 'most_sold') {
          listProductMostSold.value = [];
        } else {
          listAllProduct.value = [];
        }
      }
    } catch (e) {
      debugPrint('error get product shop dashboard: $e');
    } finally {
      if (method == 'most_sold') {
        isLoadingGetProductMostSold.value = false;
      } else {
        isLoadingGetAllProduct.value = false;
      }
    }
  }
}
