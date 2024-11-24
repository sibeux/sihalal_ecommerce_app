import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/review.dart';

class ProductReviewController extends GetxController {
  var isLoading = false.obs;
  var isLoadingSendReview = false.obs;

  var productReview = RxList<Review?>([]);

  var reviewTextController = TextEditingController();
  var sendMessageReview = ''.obs;
  var sendStarReview = 0.obs;

  void tapStar(int index) {
    sendStarReview.value = index + 1;
  }

  void onChanged(String value) {
    sendMessageReview.value = value;
    reviewTextController.text = value;
  }

  Future<void> createProductRevew({
    required String idPesanan,
    required String idProduk,
  }) async {
    isLoadingSendReview.value = true;

    const String url = 'https://sibeux.my.id/project/sihalal/review';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'create_review',
          'id_pesanan': idPesanan,
          'id_produk': idProduk,
          'id_user': Get.find<UserProfileController>().idUser,
          'bintang_rating': sendStarReview.value.toString(),
          'pesan_rating': sendMessageReview.value,
        },
      );

      if (response.body.isEmpty) {
        return;
      }

      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        final OrderController orderController = Get.find<OrderController>();
        orderController.getOrderHistory();
        orderController.changeOrderStatus(
            idPesanan: idPesanan, orderStatus: 'ulas');
        Get.back();
      } else{
        debugPrint('Error Send Data: ${data['error']}');
      }
    } catch (e) {
      debugPrint('Error Send Data: $e');
    } finally {
      isLoadingSendReview.value = false;
    }
  }

  Future<void> getProductReview(String idProduk) async {
    isLoading.value = true;
    var unescape = HtmlUnescape();

    String url =
        'https://sibeux.my.id/project/sihalal/product?method=get_ulasan&id_produk=$idProduk';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      if (listData.isEmpty) {
        productReview.value = [];
        return;
      }

      final list = listData.map((review) {
        return Review(
          idRating: review['id_rating'],
          idProduk: idProduk,
          idUser: review['id_user'],
          idPesanan: review['id_pesanan'],
          rating: review['bintang_rating'],
          ulasan: review['pesan_rating'] == null
              ? ''
              : unescape.convert(review['pesan_rating']),
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
      isLoading.value = false;
    }
  }
}
