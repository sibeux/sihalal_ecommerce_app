import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/screens/review_screen/product_review_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/recent_review.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/review_shimmer.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({
    super.key,
    required this.jumlahRating,
    required this.jumlahUlasan,
    required this.rating,
  });

  final String rating, jumlahRating, jumlahUlasan;

  @override
  Widget build(BuildContext context) {
    final rate = rating == '0.0000' ? '0.0' : ('${double.parse(rating)}');
    final productReviewController = Get.put(ProductReviewController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  'Ulasan Produk',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              jumlahUlasan == '0'
                  ? const SizedBox()
                  : Flexible(
                      flex: 0,
                      fit: FlexFit.tight,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            () => ProductReviewScreen(
                              productReviewController: productReviewController,
                            ),
                            transition: Transition.rightToLeft,
                            fullscreenDialog: true,
                            popGesture: false,
                          );
                        },
                        child: Text(
                          'Lihat Semua',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ColorPalette().primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 25,
                  color: rating == '0.0000' ? Colors.grey : HexColor('#FFD700'),
                ),
                const SizedBox(width: 5),
                Row(
                  children: [
                    Text(
                      rate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$jumlahRating penilaian',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      ' • ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      ' $jumlahUlasan ulasan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Obx(
            () => productReviewController.isLoadingFetchReview.value &&
                    jumlahUlasan != '0'
                ? const ReviewShimmer()
                : jumlahUlasan == '0'
                    ? const Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Belum ada ulasan'),
                          ],
                        ),
                      )
                    : RecentReview(
                        controller: productReviewController,
                        index: 0,
                        isFromProductDetailScreen: true,
                      ),
          ),
        ],
      ),
    );
  }
}
