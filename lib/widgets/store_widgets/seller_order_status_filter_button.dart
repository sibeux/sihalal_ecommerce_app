import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_seller_product_controller.dart';

class SellerOrderStatusFilterButton extends StatelessWidget {
  const SellerOrderStatusFilterButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final getSellerProductController = Get.find<GetSellerProductController>();
    return GestureDetector(
      onTap: () {
        if (getSellerProductController.selectedOrderStatusFilter.value !=
            title) {
          getSellerProductController.changeOrderStatusFilter(title);
        } else {
          getSellerProductController.changeOrderStatusFilter('Semua');
        }
      },
      child: Obx(
        () => Container(
          width: 120,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: getSellerProductController.selectedOrderStatusFilter.value ==
                    title
                ? Colors.black.withOpacity(0.8)
                : HexColor('#f1f3f9'),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Obx(
            () => Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: getSellerProductController
                            .selectedOrderStatusFilter.value ==
                        title
                    ? Colors.white
                    : HexColor('#6c6c6c'),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
