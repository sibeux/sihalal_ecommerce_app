import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class FilterStatusProduct extends StatelessWidget {
  const FilterStatusProduct({
    super.key,
    required this.title,
    required this.count,
    required this.index,
  });

  final String title;
  final int count, index;

  @override
  Widget build(BuildContext context) {
    final getSellerProductController = Get.find<GetSellerProductController>();
    return Column(
      children: [
        Obx(
          () => Text(
            title,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color:
                  getSellerProductController.currentFilterProductList.value ==
                          index
                      ? ColorPalette().primary
                      : Colors.black.withOpacity(1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const HeightBox(5),
        Obx(
          () => Text(
            '($count)',
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color:
                  getSellerProductController.currentFilterProductList.value ==
                          index
                      ? ColorPalette().primary
                      : Colors.black.withOpacity(1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
