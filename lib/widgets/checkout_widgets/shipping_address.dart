import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Pengiriman',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const HeightBox(5),
                Row(
                  children: [
                    Icon(
                      Ionicons.location_sharp,
                      color: ColorPalette().primary,
                      size: 18,
                    ),
                    const WidthBox(5),
                    Text(
                      'M Nasrul Wahabi | (+62) 81234567890',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const HeightBox(5),
                Text(
                  'Jl. Raya Cipadu No. 1, RT 01/01, Cipadu, Ciledug, Tangerang, Banten, 15151',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.5),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const WidthBox(15),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.black.withOpacity(0.5),
            size: 18,
          ),
        ],
      ),
    );
  }
}
