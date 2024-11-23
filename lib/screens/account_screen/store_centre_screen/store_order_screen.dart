import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_seller_product_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/order_list_container.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/seller_order_status_filter_button.dart';
import 'package:velocity_x/velocity_x.dart';

class StoreOrderScreen extends StatelessWidget {
  const StoreOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getSellerProductController = Get.find<GetSellerProductController>();
    late String title;
    if (Get.arguments != null) {
      title = Get.arguments['title'];
    } else {
      title = 'Riwayat Pesanan';
    }

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
                            itemCount: getSellerProductController
                                    .getStoreOrderList(title)
                                    .length +
                                1,
                            itemBuilder: (BuildContext context, int index) {
                              return index ==
                                      getSellerProductController
                                          .getStoreOrderList(title)
                                          .length
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const Center(
                                        child: Text("Tidak ada data lainnya"),
                                      ),
                                    )
                                  : OrderListContainer(
                                      order: getSellerProductController
                                          .getStoreOrderList(title)[index],
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
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                )
              : const SizedBox(),
        ),
        Obx(
          () => getSellerProductController.isGetOrderLoading.value
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.white,
                    size: 50,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
