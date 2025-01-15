import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/models/order.dart';
import 'package:sihalal_ecommerce_app/widgets/order_detail_widgets/buy_again_button.dart';
import 'package:velocity_x/velocity_x.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({
    super.key,
    required this.order,
    required this.unescape,
    required this.isBuyer,
  });

  final Order order;
  final HtmlUnescape unescape;
  final bool isBuyer;

  @override
  Widget build(BuildContext context) {
    final hargaBarangSatuan =
        double.parse(order.subtotalHargaBarang) / double.parse(order.jumlah);
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Detail Produk',
              style: TextStyle(
                color: Colors.black.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const WidthBox(10),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      // ini di-absorb karena buat skripsi biar tidak -
                      // terlalu banyak fitur.
                      child: AbsorbPointer(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            order.namaToko,
                            maxLines: 1,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.black.withOpacity(1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const HeightBox(15),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: order.fotoProduk,
                        height: 52,
                        width: 52,
                        fit: BoxFit.cover,
                        maxHeightDiskCache: 200,
                        maxWidthDiskCache: 200,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                    const WidthBox(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              unescape.convert(order.namaProduk),
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            '${order.jumlah} x ${priceFormatter(hargaBarangSatuan.toString().split('.').first)}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(1),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const HeightBox(15),
              const Divider(
                height: 0.4,
                thickness: 0.4,
              ),
              const HeightBox(18),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Harga',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const HeightBox(5),
                      Text(
                        priceFormatter(order.subtotalHargaBarang),
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (isBuyer)
                    BuyAgainButton(
                      idProduct: order.idProduk,
                      idUser: order.idUserToko,
                      image: order.fotoProduk,
                    ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
