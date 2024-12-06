import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_scroll_product_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shimmer_product_card.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shrink_tap_card.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

NumberFormat numberFormat =
    NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

final Shader linearGradient = LinearGradient(
  colors: <Color>[HexColor("1D6BFF"), HexColor("C125FF")],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class LeftProductCardRowScroll extends StatefulWidget {
  const LeftProductCardRowScroll({
    super.key,
    required this.color,
    required this.cardHeader,
    required this.sort,
  });

  final Color color;
  final String cardHeader, sort;

  @override
  State<StatefulWidget> createState() {
    return _LeftProductCardRowScrollState();
  }
}

class _LeftProductCardRowScrollState extends State<LeftProductCardRowScroll>
    with AutomaticKeepAliveClientMixin {
  get cardHeader => widget.cardHeader;
  get color => widget.color;
  final getScrollProductController = Get.find<GetScrollProductController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getScrollProductController.getProduct(widget.sort);
    });
    var productCardScroll = [];

    if (widget.sort == 'recent') {
      productCardScroll = getScrollProductController.recentProduct;
    } else if (widget.sort == 'random') {
      productCardScroll = getScrollProductController.leftRandomProduct;
    }

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  cardHeader,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                // child: Text(
                //   'Lihat Semua',
                //   textAlign: TextAlign.right,
                //   style: TextStyle(
                //     color: ColorPalette().primary,
                //     fontSize: 14,
                //     fontWeight: FontWeight.values[5],
                //   ),
                // ),
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Container(
          height: 385,
          decoration: BoxDecoration(
            color: color,
            // image: const DecorationImage(
            //   alignment: AlignmentDirectional.centerStart,
            //   fit: BoxFit.fitHeight,
            //   filterQuality: FilterQuality.medium,
            //   image: NetworkImage(
            //       "https://raw.githubusercontent.com/sibeux/license-sibeux/MyProgram/Mask_group.png"),
            // ),
          ),
          child: Obx(
            () => (getScrollProductController.isLoadingRecent.value &&
                        widget.sort == 'recent') ||
                    (getScrollProductController.isLoadingLeftRandom.value &&
                        widget.sort == 'random')
                ? const AbsorbPointer(
                    child: ShimmerProductCard(
                      needButtonTambah: true,
                      fromShopDashboard: false,
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // SizedBox(
                        //     width: MediaQuery.of(context).size.width * 0.43),
                        const SizedBox(width: 20),
                        // create for each product card from dummyProductCard
                        for (var product in productCardScroll)
                          ShrinkTapProduct(
                            product: product!,
                            uidProduct: product.uidProduct,
                            title: product.nama,
                            description: product.deskripsi,
                            price: double.parse(product.harga),
                            rating: product.rating,
                            image: product.foto1,
                            fromShopDashboard: false,
                            isFavorite: product.isFavorite,
                            screenFrom: 'home_horizontal',
                          ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
