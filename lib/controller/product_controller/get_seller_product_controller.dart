import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_info_product_controller.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/models/seller_order.dart';
import 'package:sihalal_ecommerce_app/models/seller_product.dart';

class GetSellerProductController extends GetxController {
  var isGetProductLoading = false.obs;
  var isGetOrderLoading = false.obs;
  var needRefresh = false.obs;

  var sellerProductList = RxList<SellerProduct>([]);
  var visibleProductList = RxList<SellerProduct>([]);
  var invisibleProductList = RxList<SellerProduct>([]);
  var outStockProductList = RxList<SellerProduct>([]);

  var allOrderList = RxList<SellerOrder>([]);
  var needSendOrderList = RxList<SellerOrder>([]);
  var allNeedSendOrderList = RxList<SellerOrder>([]);
  var processSendOrderList = RxList<SellerOrder>([]);
  var receivedOrderList = RxList<SellerOrder>([]);

  var orders = RxList<Order>([]);

  var productVisible = 0.obs;
  var productInvisible = 0.obs;
  var productOutStock = 0.obs;
  var currentFilterProductList = 0.obs;

  var selectedOrderStatusFilter = 'Semua'.obs;

  void changeOrderStatusFilter(String status) {
    selectedOrderStatusFilter.value = status;
    if (status == 'Perlu Konfirmasi') {
      needSendOrderList.value = allNeedSendOrderList
          .where((order) => order.statusPesanan == 'tunggu')
          .toList();
    } else if (status == 'Perlu Dikirim') {
      needSendOrderList.value = allNeedSendOrderList
          .where((order) => order.statusPesanan == 'proses')
          .toList();
    } else {
      needSendOrderList.value = allNeedSendOrderList;
    }
  }

  void changeFilterProductList(int index) {
    currentFilterProductList.value = index;
    update();
  }

  void getProducts({required String email, String idUser = '0'}) {
    getSellerOrder(idUserToko: idUser);
    getUserProduct(email: email);
  }

  Future<void> getUserProduct({required String email}) async {
    isGetProductLoading.value = true;
    var unescape = HtmlUnescape();

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
            nama: produk['nama_produk'] == null
                ? ''
                : unescape.convert(produk['nama_produk']),
            deskripsi: produk['deskripsi_produk'] == null
                ? ''
                : unescape.convert(produk['deskripsi_produk']),
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
            countSold: produk['jumlah_terjual'] ?? '0',
            countFavorite: produk['jumlah_favorite'] ?? '0',
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

        final shopInfoProductController = Get.find<ShopInfoProductController>();
        await shopInfoProductController
            .getShopInfo(visibleProductList.first.uidProduct);
      } else {
        sellerProductList.value = [];
        visibleProductList.value = [];
        invisibleProductList.value = [];
        outStockProductList.value = [];
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

  Future<void> getSellerOrder({required String idUserToko}) async {
    isGetOrderLoading.value = true;
    var unescape = HtmlUnescape();

    String url =
        'https://sibeux.my.id/project/sihalal/seller/order?method=get_order&id_user=$idUserToko';

    try {
      final response = await http.get(Uri.parse(url));

      final List<dynamic> listData = json.decode(response.body);

      if (listData.isNotEmpty) {
        final list = listData.map((order) {
          return SellerOrder(
            idPesanan: order['id_pesanan'],
            noPesanan: order['no_pesanan'],
            idUserPenerima: order['id_user'],
            idProduk: order['id_produk'],
            jumlah: order['jumlah'],
            pengiriman: order['pengiriman'],
            namaNoPenerima: order['nama_no_penerima'],
            alamatPenerima: unescape.convert(order['alamat_penerima']),
            subtotalHargaBarang: order['subtotal_harga_barang'],
            subtotalPengiriman: order['subtotal_pengiriman'],
            totalPembayaran: order['total_pembayaran'],
            tanggalPesanan: order['tanggal_pesanan'],
            statusPesanan: order['status_pesanan'],
            idUserToko: order['id_user_toko'],
            namaUserToko: order['nama_user'],
            namaToko: order['nama_toko'] != null
                ? unescape.convert(order['nama_toko'])
                : 'Toko ${order['nama_user']}',
            namaProduk: unescape.convert(order['nama_produk']),
            fotoProduk: order['foto_produk_1'],
          );
        }).toList();

        allOrderList.value = list;
        allNeedSendOrderList.value = list
            .where((data) =>
                data.statusPesanan == 'tunggu' ||
                data.statusPesanan == 'proses')
            .toList();
        needSendOrderList.assignAll(allNeedSendOrderList);
        processSendOrderList.value =
            list.where((data) => data.statusPesanan == 'kirim').toList();
        receivedOrderList.value = list
            .where((data) =>
                data.statusPesanan == 'selesai' || data.statusPesanan == 'ulas')
            .toList();
      } else {
        allOrderList.value = [];
        needSendOrderList.value = [];
        allNeedSendOrderList.value = [];
        processSendOrderList.value = [];
        receivedOrderList.value = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isGetOrderLoading.value = false;
    }
  }

  List<Order> getStoreOrderList(String title) {
    if (title == 'Perlu\nDikirim') {
      return needSendOrderList
          .map(
            (order) => Order(
              idPesanan: order.idPesanan,
              noPesanan: order.noPesanan,
              idUser: order.idUserPenerima,
              idProduk: order.idProduk,
              jumlah: order.jumlah,
              pengiriman: order.pengiriman,
              namaNoPenerima: order.namaNoPenerima,
              alamatPenerima: order.alamatPenerima,
              subtotalHargaBarang: order.subtotalHargaBarang,
              subtotalPengiriman: order.subtotalPengiriman,
              totalPembayaran: order.totalPembayaran,
              tanggalPesanan: order.tanggalPesanan,
              statusPesanan: order.statusPesanan,
              idUserToko: order.idUserToko,
              namaUserToko: order.namaUserToko,
              namaToko: order.namaToko,
              namaProduk: order.namaProduk,
              fotoProduk: order.fotoProduk,
            ),
          )
          .toList();
    } else if (title == 'Dalam\nPengiriman') {
      return processSendOrderList
          .map(
            (order) => Order(
              idPesanan: order.idPesanan,
              noPesanan: order.noPesanan,
              idUser: order.idUserPenerima,
              idProduk: order.idProduk,
              jumlah: order.jumlah,
              pengiriman: order.pengiriman,
              namaNoPenerima: order.namaNoPenerima,
              alamatPenerima: order.alamatPenerima,
              subtotalHargaBarang: order.subtotalHargaBarang,
              subtotalPengiriman: order.subtotalPengiriman,
              totalPembayaran: order.totalPembayaran,
              tanggalPesanan: order.tanggalPesanan,
              statusPesanan: order.statusPesanan,
              idUserToko: order.idUserToko,
              namaUserToko: order.namaUserToko,
              namaToko: order.namaToko,
              namaProduk: order.namaProduk,
              fotoProduk: order.fotoProduk,
            ),
          )
          .toList();
    } else if (title == 'Pesanan\nSelesai') {
      return receivedOrderList
          .map(
            (order) => Order(
              idPesanan: order.idPesanan,
              noPesanan: order.noPesanan,
              idUser: order.idUserPenerima,
              idProduk: order.idProduk,
              jumlah: order.jumlah,
              pengiriman: order.pengiriman,
              namaNoPenerima: order.namaNoPenerima,
              alamatPenerima: order.alamatPenerima,
              subtotalHargaBarang: order.subtotalHargaBarang,
              subtotalPengiriman: order.subtotalPengiriman,
              totalPembayaran: order.totalPembayaran,
              tanggalPesanan: order.tanggalPesanan,
              statusPesanan: order.statusPesanan,
              idUserToko: order.idUserToko,
              namaUserToko: order.namaUserToko,
              namaToko: order.namaToko,
              namaProduk: order.namaProduk,
              fotoProduk: order.fotoProduk,
            ),
          )
          .toList();
    } else {
      return allOrderList
          .map(
            (order) => Order(
              idPesanan: order.idPesanan,
              noPesanan: order.noPesanan,
              idUser: order.idUserPenerima,
              idProduk: order.idProduk,
              jumlah: order.jumlah,
              pengiriman: order.pengiriman,
              namaNoPenerima: order.namaNoPenerima,
              alamatPenerima: order.alamatPenerima,
              subtotalHargaBarang: order.subtotalHargaBarang,
              subtotalPengiriman: order.subtotalPengiriman,
              totalPembayaran: order.totalPembayaran,
              tanggalPesanan: order.tanggalPesanan,
              statusPesanan: order.statusPesanan,
              idUserToko: order.idUserToko,
              namaUserToko: order.namaUserToko,
              namaToko: order.namaToko,
              namaProduk: order.namaProduk,
              fotoProduk: order.fotoProduk,
            ),
          )
          .toList();
    }
  }
}
