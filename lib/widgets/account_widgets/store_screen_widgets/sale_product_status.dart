import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';

class SaleProductStatus extends StatelessWidget {
  const SaleProductStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatusContainer(
            onTap: () {},
            title: 'Perlu\nDikirim',
            count: 21,
          ),
          StatusContainer(
            onTap: () {},
            title: 'Dalam\nPengiriman',
            count: 2,
          ),
          StatusContainer(
            onTap: () {},
            title: 'Pesanan\nSelesai',
            count: 30,
          ),
        ],
      ),
    );
  }
}

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.onTap,
    required this.title,
    required this.count,
  });

  final void Function() onTap;
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  color: ColorPalette().primary,
                ),
                const HeightBox(5),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (title != 'Pesanan\nSelesai')
          Positioned(
            child: Container(
              alignment: Alignment.center,
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
              ),
              child: AutoSizeText(
                count.toString(),
                maxLines: 1,
                minFontSize: 5,
                maxFontSize: 11,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
