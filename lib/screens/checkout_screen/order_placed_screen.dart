import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/persistent_bar_screen.dart';
import 'package:sihalal_ecommerce_app/screens/order_detail_screen/order_detail_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderPlacedScreen extends StatelessWidget {
  const OrderPlacedScreen({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: HexColor('#f3fbe4'),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Transform.scale(
                  scale: 0.7,
                  child: Image.asset(
                    'assets/images/icon-general/tas_placed.png',
                  ),
                ),
              ),
              const HeightBox(40),
              const Text(
                'Pesanan Diterima!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const HeightBox(5),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Pesanan Anda telah kami terima dan sedang kami proses. Terima kasih telah berbelanja di Sihalal.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
              const HeightBox(40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(
                      () => const PersistenBarScreen(),
                      transition: Transition.rightToLeftWithFade,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: ColorPalette().primary,
                    elevation: 0, // Menghilangkan shadow
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Kembali ke Beranda',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const HeightBox(8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(
                      () => OrderDetailScreen(
                        order: order,
                        isBuyer: false,
                      ),
                      transition: Transition.native,
                      fullscreenDialog: true,
                      popGesture: false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: ColorPalette().primary,
                    backgroundColor: Colors.transparent,
                    elevation: 0, // Menghilangkan shadow
                    splashFactory: InkRipple.splashFactory,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: ColorPalette().primary,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Lihat Detail Pesanan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const HeightBox(60),
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
            ],
          ),
        ),
      ),
    );
  }
}
