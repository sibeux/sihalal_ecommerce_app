import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class TextTile extends StatelessWidget {
  const TextTile({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
  });

  final String title;
  final IconData icon;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final login = box.read('login') == true;

    final orderController = Get.find<OrderController>();

    return GestureDetector(
      onTap: () {
        action();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: title.toLowerCase() == 'keluar'
                  ? HexColor('#ffeced')
                  : Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: const Offset(0, 1.2),
                )
              ],
            ),
            child: Icon(
              icon,
              size: 18,
              color: title.toLowerCase() == 'keluar'
                  ? Colors.red.withOpacity(0.8)
                  : Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 35,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: title.toLowerCase() == 'keluar'
                    ? Colors.red.withOpacity(0.8)
                    : Colors.black.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const WidthBox(10),
          Obx(
            () => orderController.isLoadingGetOrderCount.value &&
                    login &&
                    (title.toLowerCase() == 'toko saya' ||
                        title.toLowerCase() == 'riwayat pesanan')
                ? SizedBox(
                    height: 25,
                    width: 25,
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: ColorPalette().primary,
                        size: 20,
                      ),
                    ),
                  )
                : (((title.toLowerCase() == 'toko saya' &&
                                orderController.orderHistoryStoreCount.value !=
                                    0) ||
                            (title.toLowerCase() == 'riwayat pesanan' &&
                                orderController.orderHistoryCount.value !=
                                    0)) &&
                        login)
                    ? Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: ColorPalette().primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: AutoSizeText(
                          title.toLowerCase() == 'riwayat pesanan'
                              ? '${orderController.orderHistoryCount.value}'
                              : '${orderController.orderHistoryStoreCount.value}',
                          maxLines: 1,
                          minFontSize: 5,
                          maxFontSize: 12,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const SizedBox(),
          ),
          Expanded(
            child: (title.toLowerCase() != 'keluar')
                ? Container(
                    // * uncomment ini agar bisa diklik di area kosong/putih
                    // color: Colors.transparent,
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Ionicons.arrow_forward_outline,
                      color: HexColor('#989999'),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
