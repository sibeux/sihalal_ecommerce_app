import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:velocity_x/velocity_x.dart';

class StatusNumDateOrder extends StatelessWidget {
  const StatusNumDateOrder({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              order.statusPesanan == 'tunggu'
                  ? 'Menunggu Konfirmasi'
                  : order.statusPesanan.contains('batal')
                      ? order.statusPesanan == 'batal_toko'
                          ? 'Dibatalkan Penjual'
                          : 'Dibatalkan'
                      : order.statusPesanan == 'proses'
                          ? 'Dikemas'
                          : order.statusPesanan == 'kirim'
                              ? 'Sedang Dikirim'
                              : 'Selesai',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            // const Spacer(),
            // if (!order.statusPesanan.contains('batal'))
            //   InkWell(
            //     onTap: () {},
            //     child: Text(
            //       'Lihat Detail',
            //       style: TextStyle(
            //         color: ColorPalette().primary,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ),
          ],
        ),
        const HeightBox(10),
        const Divider(
          height: 0.3,
          thickness: 0.3,
        ),
        const HeightBox(10),
        Text(
          order.noPesanan,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const HeightBox(10),
        Row(
          children: [
            Text(
              'Tanggal Pesanan',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              DateFormat('d MMMM yyyy, HH:mm WIB', 'id_ID')
                  .format(DateTime.parse(order.tanggalPesanan)),
              style: TextStyle(
                color: Colors.black.withOpacity(1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
