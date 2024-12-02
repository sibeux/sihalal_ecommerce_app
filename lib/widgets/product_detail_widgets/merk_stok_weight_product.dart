import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_detail_controller.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:velocity_x/velocity_x.dart';

class MerkStokWeightProduct extends StatelessWidget {
  const MerkStokWeightProduct({
    super.key,
    required this.product,
    required this.tag,
  });

  final Product product;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final productDetailController = Get.find<ProductDetailController>(tag: tag);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListTextFomat(title: 'Berat Satuan', value: "${product.berat} g"),
          // Masih ada bug di bagian stok.
          // Bug di mana stok tidak berkurang dari segi tampilan,
          // karena tidak di-refresh dari database setelah pembelian.
          // * 2 lazy 2 fix it :D (sudah tau solusinya)
          Obx(
            () => ListTextFomat(
              title: 'Stok',
              value: productDetailController.stockProduct.toString(),
            ),
          ),
          ListTextFomat(
              title: 'Kategori', value: product.kategori.capitalizeFirst!),
          ListTextFomat(title: 'Merek', value: product.merek.capitalized),
          ListTextFomat(title: 'Nomor Halal', value: product.nomorHalal),
        ],
      ),
    );
  }
}

class ListTextFomat extends StatelessWidget {
  const ListTextFomat({
    super.key,
    required this.title,
    required this.value,
  });

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: Text(
                value,
                maxLines: 1,
                style: TextStyle(
                  color: title == 'Merek'
                      ? ColorPalette().primary
                      : Colors.black.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: title == 'Merek' || title == 'Nomor Halal'
                      ? FontWeight.bold
                      : FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        if (title != 'Nomor Halal')
          const SizedBox(
            height: 7,
          ),
        if (title != 'Nomor Halal')
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
      ],
    );
  }
}
