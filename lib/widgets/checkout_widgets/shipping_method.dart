import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/checkout_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      // padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: HexColor('#ffffff'),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: HexColor('#000000').withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // terpaksa di sini karena listtile gak sejajar
            margin: const EdgeInsets.only(
              left: 15,
              top: 15,
              right: 15,
              bottom: 5,
            ),
            child: Text(
              'Metode Pengiriman',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.9),
              ),
            ),
          ),
          const ListExpedition(
            title: 'JNE',
            value: Expedition.jne,
          ),
          const ListExpedition(
            title: 'J&T',
            value: Expedition.jnt,
          ),
          const ListExpedition(
            title: 'POS',
            value: Expedition.pos,
          ),
          const HeightBox(15)
        ],
      ),
    );
  }
}

class ListExpedition extends StatelessWidget {
  const ListExpedition({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final Expedition value;

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.find<CheckoutController>();
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black.withOpacity(0.7),
        ),
      ),
      minLeadingWidth: 0,
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: Obx(
        () => Radio<Expedition>(
          activeColor: ColorPalette().primary,
          value: value,
          groupValue: checkoutController.expedition.value,
          onChanged: (Expedition? value) {
            checkoutController.expedition.value = value!;
          },
        ),
      ),
    );
  }
}
