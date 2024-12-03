import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';

class RecentReview extends StatelessWidget {
  const RecentReview({
    super.key,
    required this.controller,
    required this.index,
    required this.isFromProductDetailScreen,
    this.keyList = '',
  });

  final ProductReviewController controller;
  final int index;
  final bool isFromProductDetailScreen;
  final String keyList;

  @override
  Widget build(BuildContext context) {
    String key = '';
    if (keyList.isNotEmpty) {
      key = keyList;
    } else {
      key = Get.find<UserProfileController>().idUser;
    }
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (controller.productReview.isNotEmpty)
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: CachedNetworkImage(
                    imageUrl: controller.productReview[key]![index].fotoUser,
                    fit: BoxFit.cover,
                    height: 35,
                    width: 35,
                    maxHeightDiskCache: 100,
                    maxWidthDiskCache: 100,
                    filterQuality: FilterQuality.low,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/shimmer/profile/profile_shimmer.png',
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/shimmer/profile/profile_shimmer.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.productReview[key]![index].namaUser,
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
                                      int.parse(controller
                                          .productReview[key]![index].rating)
                                  ? HexColor('#FFD700')
                                  : Colors.grey[400],
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '• '
                            '${timeAgo(controller.productReview[key]![index].tanggal)}',
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
                )
              ],
            ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.productReview[key]![index].ulasan.isEmpty
                  ? 'Tidak ada ulasan'
                  : controller.productReview[key]![index].ulasan,
              maxLines: isFromProductDetailScreen ? 1 : null,
              style: TextStyle(
                color: controller.productReview[key]![index].ulasan.isEmpty
                    ? Colors.grey[500]
                    : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: controller.productReview[key]![index].ulasan.isEmpty
                    ? FontStyle.italic
                    : FontStyle.normal,
                overflow:
                    isFromProductDetailScreen ? TextOverflow.ellipsis : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
