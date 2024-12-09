import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/cart_controller.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:sihalal_ecommerce_app/screens/checkout_screen/order_placed_screen.dart';
import 'package:uuid/uuid.dart';

enum Expedition { jne, tiki, pos, jnt }

class CheckoutController extends GetxController {
  var quantity = 1.obs;
  var expedition = Expedition.jne.obs;
  var isLoadingCreateOrder = false.obs;
  var subTotalPrice = 0;
  var subTotalShipping = 0;
  var totalPrice = 0;
  var productStock = 0;

  @override
  void onInit() {
    super.onInit();
    quantity.value = 1;
    expedition.value = Expedition.jne;
  }

  void increment() {
    if (quantity.value < 99 && quantity.value < productStock) {
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
    final formattedHour =
        "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}";

    const uuid = Uuid();
    final randomString = uuid.v4().replaceAll('-', '').substring(0, 4);

    return "SHL/$formattedDate/$idUser$idProduct/$formattedHour$randomString";
  }

  Future<void> createOrder({
    required Product product,
    required String sellerShopName,
    required String idCart,
  }) async {
    isLoadingCreateOrder.value = true;

    final userProfileController = Get.find<UserProfileController>();
    final userAddressController = Get.find<UserAddressController>();

    const String uri = "https://sibeux.my.id/project/sihalal/order";

    try {
      DateTime now = DateTime.now();

      final address = userAddressController.addressList
          .where((element) => element!.isPrimary);
      final name = address.first!.name;
      final phone = address.first!.phone;

      final street = address.first!.streetAddress;
      final city = address.first!.city;
      final province = address.first!.province;
      final postalCode = address.first!.postalCode;

      final String noPesanan = generateNumbOrder(
          idUser: userProfileController.idUser, idProduct: product.uidProduct);
      final String date = now.toString();

      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'create_order',
          'no_pesanan': noPesanan,
          'id_user': userProfileController.idUser,
          'id_produk': product.uidProduct,
          'jumlah': quantity.value.toString(),
          'pengiriman': expedition.value.toString().split('.').last,
          'nama_no_penerima': '$name | (+62) $phone',
          'alamat_penerima': '$street, $city, $province, $postalCode',
          'subtotal_harga_barang': subTotalPrice.toString(),
          'subtotal_pengiriman': subTotalShipping.toString(),
          'total_pembayaran': totalPrice.toString(),
          'tanggal_pesanan': date,
          'status_pesanan': 'tunggu',
        },
      );

      if (response.body.isEmpty) {
        debugPrint('Error: Response body is empty');
        return;
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody['status'] == 'success') {
        Get.find<OrderController>()
            .getOrderHistoryCount(userProfileController.idUser);
        if (idCart.isNotEmpty) {
          final cartController = Get.find<CartController>();
          cartController.changeCart(
            method: 'delete',
            idProduk: product.uidProduct,
            idCart: idCart,
          );
        }
        Get.offUntil(
          MaterialPageRoute(
            builder: (_) => OrderPlacedScreen(
              order: Order(
                idPesanan: '',
                noPesanan: noPesanan,
                idUser: userProfileController.idUser,
                idProduk: product.uidProduct,
                jumlah: quantity.value.toString(),
                pengiriman: expedition.value.toString().split('.').last,
                namaNoPenerima: '$name | (+62) $phone',
                alamatPenerima: '$street, $city, $province, $postalCode',
                subtotalHargaBarang: subTotalPrice.toString(),
                subtotalPengiriman: subTotalShipping.toString(),
                totalPembayaran: totalPrice.toString(),
                tanggalPesanan: date,
                statusPesanan: 'tunggu',
                idUserToko: product.uidUser,
                namaUserToko: sellerShopName,
                namaToko: sellerShopName,
                namaProduk: product.nama,
                fotoProduk: product.foto1,
              ),
            ),
            fullscreenDialog: true,
          ),
          (route) => route.isFirst,
        );

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
