import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
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
                        onTap: () {},
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
            () => productReviewController.isLoading.value && jumlahUlasan != '0'
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
                    : RecentReview(controller: productReviewController),
          ),
        ],
      ),
    );
  }
}

class RecentReview extends StatelessWidget {
  const RecentReview({
    super.key,
    required this.controller,
  });

  final ProductReviewController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  imageUrl: controller.productReview[0]!.fotoUser,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.productReview[0]!.namaUser,
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
                          color:
                              i < int.parse(controller.productReview[0]!.rating)
                                  ? HexColor('#FFD700')
                                  : Colors.grey[400],
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '• ' '${timeAgo(controller.productReview[0]!.tanggal)}',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.productReview[0]!.ulasan,
              maxLines: 4,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
