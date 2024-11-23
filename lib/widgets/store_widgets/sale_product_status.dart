import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_seller_product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/store_order_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SaleProductStatus extends StatelessWidget {
  const SaleProductStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final getSellerProductController = Get.find<GetSellerProductController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => StatusContainer(
              title: 'Perlu\nDikirim',
              count: getSellerProductController.needSendOrderList.length,
            ),
          ),
          Obx(
            () => StatusContainer(
              title: 'Dalam\nPengiriman',
              count: getSellerProductController.processSendOrderList.length,
            ),
          ),
          const StatusContainer(
            title: 'Pesanan\nSelesai',
            count: 0,
          ),
        ],
      ),
    );
  }
}

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final getSellerProductController = Get.find<GetSellerProductController>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => const StoreOrderScreen(),
              transition: Transition.downToUp,
              popGesture: false,
              fullscreenDialog: true,
              arguments: {
                'title': title,
              }
            );
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Transform.scale(
                    scale: 0.75,
                    child: Image.asset(
                      title == 'Perlu\nDikirim'
                          ? 'assets/images/icon-general/tunggu.png'
                          : title == 'Dalam\nPengiriman'
                              ? 'assets/images/icon-general/kirim.png'
                              : 'assets/images/icon-general/selesai.png',
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const HeightBox(5),
              ],
            ),
          ),
        ),
        if (title != 'Pesanan\nSelesai')
          Obx(
            () => getSellerProductController.isGetOrderLoading.value
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: ColorPalette().primary,
                        size: 20,
                      ),
                    ),
                  )
                : (title == 'Perlu\nDikirim' &&
                            getSellerProductController
                                .needSendOrderList.isEmpty) ||
                        (title == 'Dalam\nPengiriman' &&
                            getSellerProductController
                                .processSendOrderList.isEmpty)
                    ? const SizedBox()
                    : Positioned(
                        child: Container(
                          alignment: Alignment.center,
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ColorPalette().primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: AutoSizeText(
                            count.toString(),
                            maxLines: 1,
                            minFontSize: 5,
                            maxFontSize: 11,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
          ),
      ],
    );
  }
}
