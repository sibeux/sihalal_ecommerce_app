import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/review_buy_button.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/strip_line.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderListContainer extends StatelessWidget {
  const OrderListContainer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return index != 5 - 1
        ? Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor('#f1f3f9'), width: 0.3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://sibeux.my.id/project/sihalal/uploads/23_IMG_20241110222517_TMGX.jpg',
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          maxHeightDiskCache: 200,
                          maxWidthDiskCache: 200,
                          filterQuality: FilterQuality.medium,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Gula 500 gram Gula Putih Gula Pasir 500 gram Gula Lokal setengah kilo',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const HeightBox(2),
                            Text(
                              '1 Barang',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11,
                                color: HexColor('#6c6c6c'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Rp2.600.212',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const WidthBox(15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: HexColor('#d8fddf'),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Selesai',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 11,
                          color: ColorPalette().primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  ],
                ),
                const HeightBox(10),
                Row(
                  children: [
                    Text(
                      'No. Pesanan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'SHL-2021100001',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const HeightBox(5),
                Row(
                  children: [
                    Text(
                      'Tanggal',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '12 Oktober 2024',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const HeightBox(10),
                const ReviewBuyButton(),
                const HeightBox(15),
                CustomPaint(
                  painter: StripLine(),
                  child: Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Center(
              child: Text("Tidak ada data lainnya"),
            ),
          );
  }
}
