import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:velocity_x/velocity_x.dart';

class PaymentDetail extends StatelessWidget {
  const PaymentDetail({
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
          'Rincian Pembayaran',
          style: TextStyle(
            color: Colors.black.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const HeightBox(15),
        Row(
          children: [
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              'COD (Bayar di Tempat)',
              style: TextStyle(
                color: Colors.black.withOpacity(1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const HeightBox(15),
        const Divider(
          height: 0.3,
          thickness: 0.3,
        ),
        const HeightBox(15),
        Row(
          children: [
            Text(
              'Subtotal Harga Barang',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              priceFormatter(order.subtotalHargaBarang),
              style: TextStyle(
                color: Colors.black.withOpacity(1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const HeightBox(10),
        Row(
          children: [
            Text(
              'Subtotal Pengiriman',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              priceFormatter(order.subtotalPengiriman),
              style: TextStyle(
                color: Colors.black.withOpacity(1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const HeightBox(15),
        const Divider(
          height: 0.3,
          thickness: 0.3,
        ),
        const HeightBox(15),
        Row(
          children: [
            Text(
              'Total Pembayaran',
              style: TextStyle(
                color: Colors.black.withOpacity(1),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              priceFormatter(order.totalPembayaran),
              style: TextStyle(
                color: Colors.black.withOpacity(1),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
