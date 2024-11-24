import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingInfo extends StatelessWidget {
  const ShippingInfo({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informasi Pengiriman',
          style: TextStyle(
            color: Colors.black.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const HeightBox(15),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                'Jasa Ekspedisi',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Text(
                order.pengiriman == 'jnt'
                    ? 'J&T'
                    : order.pengiriman == 'pos'
                        ? 'POS'
                        : 'JNE',
                style: TextStyle(
                  color: Colors.black.withOpacity(1),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        const HeightBox(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                'Alamat',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.namaNoPenerima.split('|')[0].trim(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const HeightBox(3),
                  Text(
                    order.namaNoPenerima.split('|')[1].trim(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const HeightBox(3),
                  Text(
                    order.alamatPenerima.trim(),
                    maxLines: 3,
                    style: TextStyle(
                      color: Colors.black.withOpacity(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
