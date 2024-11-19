import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';

class OrderStatusButton extends StatelessWidget {
  const OrderStatusButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return GestureDetector(
      onTap: () {
        if (orderController.selectedOrderStatus.value != title) {
          orderController.changeOrderStatus(title);
        } else {
          orderController.changeOrderStatus('Semua');
        }
      },
      child: Obx(
        () => Container(
          width: 80,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: orderController.selectedOrderStatus.value == title
                ? Colors.black.withOpacity(0.8)
                : HexColor('#f1f3f9'),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Obx(
            () => Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: orderController.selectedOrderStatus.value == title
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
