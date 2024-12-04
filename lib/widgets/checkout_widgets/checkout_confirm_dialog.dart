import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/checkout_controller.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:velocity_x/velocity_x.dart';

void checkoutConfirmDialog(
  BuildContext context, {
  required Product product,
  required String sellerShopName,
  required String idCart,
}) {
  showDialog<void>(
    barrierDismissible: true,
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 0,
          bottom: 15,
        ),
        title: Image.asset(
          'assets/images/icon-general/tas_confirm.png',
          height: 120,
          width: 120,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HeightBox(10),
            TextButton(
              onPressed: null,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: const Text(
                'Pastikan pesanan sesuai!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'Harap periksa kembali pesanan Anda sebelum melanjutkan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      final checkoutController = Get.find<CheckoutController>();
                      Navigator.of(context).pop();
                      await checkoutController.createOrder(
                        product: product,
                        sellerShopName: sellerShopName,
                        idCart: idCart,
                      );
                    },
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorPalette().primary,
                      ),
                      child: const Text(
                        'Konfirmasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
