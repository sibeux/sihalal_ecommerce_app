import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/recent_review.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key, required this.productReviewController});

  final ProductReviewController productReviewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
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
        title: const Text('Ulasan Produk'),
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
          Obx(
            () => productReviewController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                // * listview di column harus di-wrap dengan expanded
                : Expanded(
                    child: ListView.builder(
                      itemCount: productReviewController.productReview.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              RecentReview(
                                controller: productReviewController,
                                index: index,
                              ),
                              const HeightBox(15),
                              const Divider(
                                height: 0.3,
                                thickness: 0.3,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
