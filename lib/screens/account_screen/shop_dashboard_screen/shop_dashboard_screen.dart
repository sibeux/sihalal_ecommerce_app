import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopDashboardScreen extends StatelessWidget {
  const ShopDashboardScreen({
    super.key,
    required this.namaToko,
    required this.fotoToko,
    required this.lokasiToko,
    required this.ratingToko,
    required this.jumlahRating,
  });

  final String namaToko, fotoToko, lokasiToko;
  final String ratingToko, jumlahRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 170,
                ),
                Text(
                  namaToko,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const HeightBox(15),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            size: 20,
                            color: ColorPalette().primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              lokasiToko,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.8),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '$ratingToko ($jumlahRating penilaian)',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.8),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: ColorPalette().primary,
              toolbarHeight: 100,
              titleSpacing: 0,
              centerTitle: true,
              leading: Column(
                children: [
                  const HeightBox(10),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              title: Container(
                alignment: Alignment.center,
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  color: HexColor('#fefffe'),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/splash/splash-text.png'),
                    matchTextDirection: true,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: HexColor('#fefffe'),
                  width: 5,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  imageUrl: fotoToko,
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                  maxWidthDiskCache: 200,
                  maxHeightDiskCache: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
