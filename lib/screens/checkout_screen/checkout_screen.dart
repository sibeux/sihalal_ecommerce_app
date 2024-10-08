import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/address_stripe.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/button_widget.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/order_detail.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/payment_method.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/product_info.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/shipping_address.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/shipping_method.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen(
      {super.key, required this.product, required this.shopName});

  final Product product;
  final String shopName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette().white,
        titleSpacing: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Checkout'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeightBox(15),
                  const ShippingAddress(),
                  const HeightBox(15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 5,
                    child: CustomPaint(
                      painter: DiagonalStripedPainter(),
                    ),
                  ),
                  const HeightBox(15),
                  ProductInfo(
                    product: product,
                    shopName: shopName,
                  ),
                  const HeightBox(15),
                  Divider(
                    color: HexColor('#eff4f8'),
                    height: 8,
                    thickness: 8,
                  ),
                  const HeightBox(15),
                  const ShippingMethod(),
                  const HeightBox(15),
                  Divider(
                    color: HexColor('#eff4f8'),
                    height: 8,
                    thickness: 8,
                  ),
                  const PaymentMethod(),
                  Divider(
                    color: HexColor('#eff4f8'),
                    height: 8,
                    thickness: 8,
                  ),
                  OrderDetail(
                    product: product,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
              color: HexColor('#fefeff'),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: const ButtonCreateOrder(),
          ),
        ],
      ),
    );
  }
}
