import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';

enum Expedition { jne, tiki, pos, jnt }

class CheckoutController extends GetxController {
  var quantity = 1.obs;
  var expedition = Expedition.jne.obs;
  var isLoadingCreateOrder = false.obs;
  var subTotalPrice = 0;
  var subTotalShipping = 0;
  var totalPrice = 0;

  @override
  void onInit() {
    super.onInit();
    quantity.value = 1;
    expedition.value = Expedition.jne;
  }

  void increment() {
    if (quantity.value < 99) {
      quantity.value++;
    }
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  String generateNumbOrder(
      {required String idUser, required String idProduct}) {
    final now = DateTime.now();
    final formattedDate =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";

    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final randomString =
        List.generate(4, (index) => chars[random.nextInt(chars.length)]).join();

    return "SHL/$formattedDate/$idUser$idProduct$randomString";
  }

  Future<void> createOrder({required String idProduct}) async {
    isLoadingCreateOrder.value = true;

    final userProfileController = Get.find<UserProfileController>();
    final userAddressController = Get.find<UserAddressController>();

    const String uri = "https://sibeux.my.id/project/sihalal/order";

    try {
      await initializeDateFormatting('id_ID', null);
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('d MMMM yyyy', 'id_ID').format(now);

      final address = userAddressController.addressList
          .where((element) => element!.isPrimary);
      final name = address.first!.name;
      final phone = address.first!.phone;

      final street = address.first!.streetAddress;
      final city = address.first!.city;
      final province = address.first!.province;
      final postalCode = address.first!.postalCode;

      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'create_order',
          'no_pesanan': generateNumbOrder(
              idUser: userProfileController.idUser, idProduct: idProduct),
          'id_user': userProfileController.idUser,
          'id_produk': idProduct,
          'jumlah': quantity.value.toString(),
          'pengiriman': expedition.value.toString().split('.').last,
          'nama_no_penerima': '$name | (+62) $phone',
          'alamat_penerima': '$street, $city, $province, $postalCode',
          'subtotal_harga_barang': subTotalPrice.toString(),
          'subtotal_pengiriman': subTotalShipping.toString(),
          'total_pembayaran': totalPrice.toString(),
          'tanggal_pesanan': formattedDate,
          'status_pesanan': 'tunggu',
        },
      );

      if (response.body.isEmpty) {
        debugPrint('Error: Response body is empty');
        return;
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody['status'] == 'success') {
        debugPrint('Success create order: $responseBody');
      } else {
        debugPrint('Failed create order: $responseBody');
      }
    } catch (e, trace) {
      debugPrint('Error: $e');
      debugPrint('Trace: $trace');
    } finally {
      isLoadingCreateOrder.value = false;
    }
  }

  get getExpedition => Expedition.values;
}
