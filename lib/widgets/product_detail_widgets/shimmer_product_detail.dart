import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class ShimmerProductDetail extends StatelessWidget {
  const ShimmerProductDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 15,
                width: 120,
                color: HexColor('#e9e9e9'),
              ),
            ),
            const HeightBox(12),
            Container(
              height: 15,
              width: double.infinity,
              color: HexColor('#f7f6f7'),
            ),
            const HeightBox(12),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 15,
                width: 180,
                color: HexColor('#e9e9e9'),
              ),
            ),
            const HeightBox(12),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 15,
                width: 140,
                color: HexColor('#e9e9e9'),
              ),
            ),
            const HeightBox(12),
            Container(
              height: 15,
              width: double.infinity,
              color: HexColor('#f7f6f7'),
            ),
          ],
        ),
      );
  }
}
