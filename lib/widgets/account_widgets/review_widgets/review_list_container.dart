import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';

class ReviewListContainer extends StatelessWidget {
  const ReviewListContainer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final productReviewController = Get.find<ProductReviewController>();
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productReviewController.productReview[index]!.namaUser,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      size: 15,
                      color: i <
                              int.parse(productReviewController
                                  .productReview[index]!.rating)
                          ? HexColor('#FFD700')
                          : Colors.grey[400],
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '• '
                    '${timeAgo(productReviewController.productReview[index]!.tanggal)}',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              productReviewController.productReview[index]!.ulasan,
              maxLines: null,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}