import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/widgets/order_detail_widgets/detail_product.dart';
import 'package:sihalal_ecommerce_app/widgets/order_detail_widgets/payment_detail.dart';
import 'package:sihalal_ecommerce_app/widgets/order_detail_widgets/shipping_info.dart';
import 'package:sihalal_ecommerce_app/widgets/order_detail_widgets/status_num_date_order.dart';
import 'package:velocity_x/velocity_x.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen(
      {super.key, required this.order, required this.isBuyer});

  final Order order;
  final bool isBuyer;

  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Detail Pesanan'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: ColorPalette().primary,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: const Divider(
                        thickness: 0.5,
                      ),
                    ),
                  ),
                  const HeightBox(15),
                  // * Status, Nomor Pesanan, dan Tanggal Pesanan
                  StatusNumDateOrder(order: order),
                  const HeightBox(20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 8,
                    child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: Divider(
                        color: HexColor('#eff4f8'),
                        thickness: 8,
                      ),
                    ),
                  ),
                  const HeightBox(20),
                  // * Detail Produk
                  DetailProduct(
                    order: order,
                    unescape: unescape,
                    isBuyer: isBuyer,
                  ),
                  const HeightBox(30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 8,
                    child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: Divider(
                        color: HexColor('#eff4f8'),
                        thickness: 8,
                      ),
                    ),
                  ),
                  const HeightBox(20),
                  // * Informasi Pengiriman
                  ShippingInfo(order: order),
                  const HeightBox(20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 8,
                    child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: Divider(
                        color: HexColor('#eff4f8'),
                        thickness: 8,
                      ),
                    ),
                  ),
                  const HeightBox(20),
                  // * Rincian Pembayaran
                  PaymentDetail(order: order),
                  const HeightBox(30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
