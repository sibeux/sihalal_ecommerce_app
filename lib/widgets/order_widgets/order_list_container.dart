import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/button/cancel_order_button.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/button/review_buy_button.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/strip_line.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderListContainer extends StatelessWidget {
  const OrderListContainer({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: HexColor('#f1f3f9'), width: 0.3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: order.fotoProduk,
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
                        Text(
                          order.namaProduk,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const HeightBox(2),
                        Text(
                          '${order.jumlah} Barang',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#6c6c6c'),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          priceFormatter(order.totalPembayaran),
                          maxLines: 1,
                          style: const TextStyle(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: order.statusPesanan == 'tunggu'
                        ? Colors.blue.withOpacity(0.2)
                        : order.statusPesanan == 'proses'
                            ? Colors.amber.withOpacity(0.2)
                            : order.statusPesanan == 'batal'
                                ? Colors.red.withOpacity(0.2)
                                : HexColor('#d8fddf'),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    order.statusPesanan == 'tunggu'
                        ? 'Menunggu Konfirmasi'
                        : order.statusPesanan == 'proses'
                            ? 'Dikemas Penjual'
                            : order.statusPesanan == 'batal'
                                ? 'Dibatalkan'
                                : 'Selesai',
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 11,
                      color: order.statusPesanan == 'tunggu'
                          ? const Color.fromARGB(255, 46, 139, 246)
                              .withOpacity(0.8)
                          : order.statusPesanan == 'proses'
                              ? const Color.fromARGB(255, 196, 130, 23)
                                  .withOpacity(0.8)
                              : order.statusPesanan == 'batal'
                                  ? const Color.fromARGB(255, 196, 23, 23)
                                  : ColorPalette().primary,
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
                  order.noPesanan,
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
                  DateFormat('d MMMM yyyy', 'id_ID')
                      .format(DateTime.parse(order.tanggalPesanan)),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const HeightBox(10),
            order.statusPesanan == 'tunggu'
                ? CancelOrderButton(
                    idPesanan: order.idPesanan,
                  )
                : ReviewBuyButton(
                  statusPesanan: order.statusPesanan,
                ),
            const HeightBox(15),
            SizedBox(
              height: 1,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: StripLine(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
