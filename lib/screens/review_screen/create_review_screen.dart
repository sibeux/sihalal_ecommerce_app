import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/review_widgets/button_send_review.dart';
import 'package:sihalal_ecommerce_app/widgets/review_widgets/form_review_message.dart';
import 'package:sihalal_ecommerce_app/widgets/review_widgets/star_blank_button.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateReviewScreen extends StatelessWidget {
  const CreateReviewScreen({
    super.key,
    required this.idPesanan,
    required this.namaProduk,
    required this.idProduk,
  });

  final String idPesanan, idProduk, namaProduk;

  @override
  Widget build(BuildContext context) {
    final productReviewController = Get.put(ProductReviewController());
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
        title: const Text('Beri Ulasan'),
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
          const HeightBox(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaProduk,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                const HeightBox(25),
                Text(
                  'Tekan bintang untuk memberi penilaian',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const HeightBox(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const WidthBox(20),
                    for (int i = 0; i < 5; i++)
                      StarBlankButton(
                        productReviewController: productReviewController,
                        index: i,
                      ),
                    const WidthBox(20),
                  ],
                ),
                const HeightBox(20),
                Text(
                  'Berikan pesan ulasan (opsional)',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const HeightBox(20),
                const FormReviewMessage()
              ],
            ),
          ),
          const Spacer(),
          ButtonSendReview(
            idPesanan: idPesanan,
            idProduk: idProduk,
          ),
        ],
      ),
    );
  }
}
