import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_seller_product_controller.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/models/seller_order.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/order_list_container.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/seller_order_status_filter_button.dart';
import 'package:velocity_x/velocity_x.dart';

class StoreOrderScreen extends StatelessWidget {
  const StoreOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getSellerProductController = Get.find<GetSellerProductController>();
    late String title;
    late List<SellerOrder> list;
    if (Get.arguments != null) {
      title = Get.arguments['title'];
    } else {
      title = 'Riwayat Pesanan';
    }

    if (title == 'Perlu\nDikirim') {
      list = getSellerProductController.needSendOrderList.cast<SellerOrder>();
    } else if (title == 'Dalam\nPengiriman') {
      list =
          getSellerProductController.processSendOrderList.cast<SellerOrder>();
    } else if (title == 'Pesanan\nSelesai') {
      list = getSellerProductController.receivedOrderList.cast<SellerOrder>();
    } else {
      list = getSellerProductController.allOrderList.cast<SellerOrder>();
    }

    final orderList = list
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
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#fefffe'),
          appBar: AppBar(
            backgroundColor: HexColor('#fefffe'),
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 60,
            titleSpacing: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              '${title.split('\n')[0]} ${title.split('\n')[1]}',
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                if (title == 'Perlu\nDikirim')
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SellerOrderStatusFilterButton(
                        title: 'Perlu Konfirmasi',
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SellerOrderStatusFilterButton(
                        title: 'Perlu Dikirim',
                      ),
                    ],
                  ),
                const HeightBox(10),
                Obx(
                  () => Expanded(
                    child: getSellerProductController.isGetOrderLoading.value
                        ? const SizedBox()
                        : ListView.builder(
                            itemCount: list.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              return index == list.length
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const Center(
                                        child: Text("Tidak ada data lainnya"),
                                      ),
                                    )
                                  : OrderListContainer(
                                      order: orderList[index],
                                      isBuyer: false,
                                    );
                            }),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => getSellerProductController.isGetOrderLoading.value
              ? const Opacity(
                  opacity: 1,
                  child: ModalBarrier(dismissible: false, color: Colors.white),
                )
              : const SizedBox(),
        ),
        Obx(
          () => getSellerProductController.isGetOrderLoading.value
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: ColorPalette().primary,
                    size: 50,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
