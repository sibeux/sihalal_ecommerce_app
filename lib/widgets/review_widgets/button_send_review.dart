import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';

class ButtonSendReview extends StatelessWidget {
  const ButtonSendReview({
    super.key,
    required this.idPesanan,
    required this.idProduk,
  });

  final String idPesanan, idProduk;

  @override
  Widget build(BuildContext context) {
    final productReviewController = Get.find<ProductReviewController>();
    return Container(
      width: double.infinity,
      height: 60,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Obx(
                () => AbsorbPointer(
                  absorbing: productReviewController.sendStarReview.value == 0,
                  child: ElevatedButton(
                    onPressed: () async {
                      await productReviewController.createProductRevew(
                        idPesanan: idPesanan,
                        idProduk: idProduk,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          productReviewController.sendStarReview.value == 0
                              ? HexColor('#a8b5c8')
                              : Colors.white,
                      backgroundColor:
                          productReviewController.sendStarReview.value == 0
                              ? HexColor('#e5eaf5')
                              : ColorPalette().primary,
                      elevation: 0, // Menghilangkan shadow
                      splashFactory: InkRipple.splashFactory,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(
                        double.infinity,
                        40,
                      ),
                    ),
                    child: productReviewController.isLoadingSendReview.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Text(
                            'Kirim Ulasan',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
