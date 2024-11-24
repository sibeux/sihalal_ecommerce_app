import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';

class StarBlankButton extends StatelessWidget {
  const StarBlankButton({
    super.key,
    required this.productReviewController,
    required this.index,
  });

  final ProductReviewController productReviewController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        productReviewController.tapStar(index);
      },
      icon: Obx(
        () => productReviewController.sendStarReview.value > index
            ? Icon(
                Ionicons.star,
                size: 30,
                color: Colors.amber.withOpacity(0.7),
              )
            : Icon(
                Ionicons.star_outline,
                size: 30,
                color: Colors.black.withOpacity(0.7),
              ),
      ),
    );
  }
}
