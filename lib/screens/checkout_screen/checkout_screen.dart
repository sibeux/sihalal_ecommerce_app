import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/widgets/checkout_widgets/address_stripe.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette().white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette().white,
        titleSpacing: 0,
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
          const HeightBox(15),
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alamat Pengiriman',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      const HeightBox(5),
                      Row(
                        children: [
                          Icon(
                            Ionicons.location_sharp,
                            color: ColorPalette().primary,
                            size: 18,
                          ),
                          const WidthBox(5),
                          Text(
                            'M Nasrul Wahabi | (+62) 81234567890',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const HeightBox(5),
                      Text(
                        'Jl. Raya Cipadu No. 1, RT 01/01, Cipadu, Ciledug, Tangerang, Banten, 15151',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const WidthBox(15),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black.withOpacity(0.5),
                  size: 18,
                ),
              ],
            ),
          ),
          const HeightBox(15),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 5,
            child: CustomPaint(
              painter: DiagonalStripedPainter(),
            ),
          ),
        ],
      ),
    );
  }
}
