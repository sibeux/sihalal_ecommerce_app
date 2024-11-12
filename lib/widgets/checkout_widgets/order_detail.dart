import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/checkout_controller.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.find<CheckoutController>();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Ionicons.reader_outline,
                color: ColorPalette().primary,
                size: 24,
              ),
              const WidthBox(10),
              Text(
                'Detail Pesanan',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.9),
                ),
              ),
            ],
          ),
          const HeightBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  'Subtotal Harga (${checkoutController.quantity.value} Barang)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Obx(
                () => Text(
                  priceFormatter((int.parse(product.harga) *
                          checkoutController.quantity.value)
                      .toString()),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal Pengiriman',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              Obx(
                () => Text(
                  priceFormatter(shippingCost(checkoutController)),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(15),
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          const HeightBox(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette().primary,
                ),
              ),
              Obx(
                () => Text(
                  priceFormatter(((int.parse(product.harga) *
                              checkoutController.quantity.value +
                          20000)
                      .toString())),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: ColorPalette().primary,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(10),
        ],
      ),
    );
  }

  String shippingCost(dynamic checkoutController) {
    const fix = 20000;
    final totalBerat =
        int.parse(product.berat) * checkoutController.quantity.value;
    final sumCostShipping = totalBerat / 1000;
    // .ceil().toDouble() is used to bulatkan ke atas
    final total =
        (sumCostShipping < 1 ? 1 : sumCostShipping.ceil().toDouble()) * fix;
    // toStringAsFixed(0) is used to hapus 0 di belakang koma
    return total.toStringAsFixed(0);
  }
}
