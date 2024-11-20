import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';

class OrderController extends GetxController {
  var selectedOrderStatusFilter = 'Semua'.obs;
  var isLoadingGetOrder = false.obs;
  var orderList = RxList<Order>([]);

  @override
  void onInit() async {
    super.onInit();
    await getOrderHistory();
  }

  void changeOrderStatusFilter(String status) {
    selectedOrderStatusFilter.value = status;
  }

  Future<void> changeOrderStatus({required String idPesanan, required String orderStatus}) async {
    isLoadingGetOrder.value = true;

    const String url = "https://sibeux.my.id/project/sihalal/order";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'change_order_status',
          'id_pesanan': idPesanan,
          'status_pesanan': orderStatus,
        },
      );

      if (response.body.isEmpty) {
        debugPrint('Error: Response body is empty');
        return;
      }

      final responseBody = jsonDecode(response.body);

      if (responseBody['status'] == 'success') {
        await getOrderHistory();

        debugPrint('Success create order: $responseBody');
      } else {
        debugPrint('Failed create order: $responseBody');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoadingGetOrder.value = false;
    }
  }

  Future<void> getOrderHistory() async {
    final userProfileController = Get.find<UserProfileController>();

    isLoadingGetOrder.value = true;
    final String idUser = userProfileController.idUser;

    if (idUser.isEmpty) {
      isLoadingGetOrder.value = false;
      orderList.value = [];
      return;
    }

    final String url =
        "https://sibeux.my.id/project/sihalal/order?method=get_order_history&id_user=$idUser";

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      if (listData.isNotEmpty) {
        final list = listData
            .map(
              (order) => Order(
                idPesanan: order['id_pesanan'],
                noPesanan: order['no_pesanan'],
                idUser: idUser,
                idProduk: order['id_produk'],
                jumlah: order['jumlah'],
                pengiriman: order['pengiriman'],
                namaNoPenerima: order['nama_no_penerima'],
                alamatPenerima: order['alamat_penerima'],
                subtotalHargaBarang: order['subtotal_harga_barang'],
                subtotalPengiriman: order['subtotal_pengiriman'],
                totalPembayaran: order['total_pembayaran'],
                tanggalPesanan: order['tanggal_pesanan'],
                statusPesanan: order['status_pesanan'],
                idUserToko: order['id_user_toko'],
                namaToko: order['nama_toko'],
                namaProduk: order['nama_produk'],
                fotoProduk: order['foto_produk_1'],
              ),
            )
            .toList();

        orderList.value = list;
      } else {
        orderList.value = [];
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoadingGetOrder.value = false;
    }
  }
}
