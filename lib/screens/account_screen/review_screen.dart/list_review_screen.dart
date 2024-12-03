import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/review_widgets/review_list_container.dart';
import 'package:velocity_x/velocity_x.dart';

class ListReviewScreen extends StatelessWidget {
  const ListReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productReviewController = Get.put(ProductReviewController());
    productReviewController.fetchReview();
    final idUser = Get.find<UserProfileController>().idUser;
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
        title: const Text('Ulasan Saya'),
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
            () => productReviewController.isLoadingFetchReview.value
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                            color: ColorPalette().primary,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                  )
                : productReviewController.productReview.isEmpty
                    ? const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum ada ulasan',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount:
                              productReviewController.productReview[idUser]!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  ReviewListContainer(index: index),
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
