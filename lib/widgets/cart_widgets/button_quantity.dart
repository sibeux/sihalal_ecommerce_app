import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/cart_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonQuantity extends StatelessWidget {
  const ButtonQuantity({
    super.key,
    required this.idCart,
    required this.idProduct,
  });

  final String idCart, idProduct;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            cartController.decrement(
              keyQty: idCart,
            );
          },
          child: Obx(() => Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: cartController.quantity[idCart]! == 1
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  cartController.quantity[idCart]! == 1
                      ? Icons.delete_outline_outlined
                      : Icons.remove,
                  color: cartController.quantity[idCart]! == 1
                      ? Colors.black
                      : Colors.red,
                  size: 16,
                ),
              )),
        ),
        const WidthBox(10),
        Container(
          height: 30,
          width: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Obx(
            () => Text(
              cartController.quantity[idCart]!.toString(),
              style: TextStyle(
                color: ColorPalette().primary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const WidthBox(10),
        GestureDetector(
          onTap: () {
            cartController.increment(
              keyQty: idCart,
              keyStock: idProduct,
            );
          },
          child: Obx(
            () => Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cartController.quantity[idCart]! == 99 ||
                        cartController.quantity[idCart]! ==
                            cartController.productStock[idProduct]!
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(
                Icons.add,
                color: cartController.quantity[idCart]! == 99 ||
                        cartController.quantity[idCart]! ==
                            cartController.productStock[idProduct]!
                    ? Colors.grey
                    : Colors.blue,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
