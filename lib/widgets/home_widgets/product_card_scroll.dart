import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/shimmer_product_card.dart';
import 'package:sihalal_ecommerce_app/widgets/little_particle.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/shrink_tap_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

NumberFormat numberFormat =
    NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

final Shader linearGradient = LinearGradient(
  colors: <Color>[HexColor("1D6BFF"), HexColor("C125FF")],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class ProductCardRowScroll extends StatefulWidget {
  const ProductCardRowScroll({
    super.key,
    required this.color,
    required this.cardHeader,
    required this.sort,
  });

  final String color, cardHeader, sort;

  @override
  State<StatefulWidget> createState() {
    return _ProductCardRowScrollState();
  }
}

class _ProductCardRowScrollState extends State<ProductCardRowScroll> {
  get cardHeader => widget.cardHeader;
  get color => widget.color;
  final getScrollLeftProductController =
      Get.put(GetScrollLeftProductController());

  @override
  Widget build(BuildContext context) {
    getScrollLeftProductController.getLeftProduct(widget.sort);
    final productCardScroll = getScrollLeftProductController.recentProduct;

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
                  child: Text(
                    'Lihat Semua',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ColorPalette().primary,
                      fontSize: 14,
                      fontWeight: FontWeight.values[5],
                    ),
                  )),
            )
          ],
        ),
        const SizedBox(height: 15),
        Container(
          height: 385,
          decoration: BoxDecoration(
            color: HexColor(color),
            image: const DecorationImage(
              alignment: AlignmentDirectional.centerStart,
              fit: BoxFit.fitHeight,
              image: NetworkImage(
                  "https://raw.githubusercontent.com/sibeux/license-sibeux/MyProgram/Mask_group.png"),
            ),
          ),
          child: Obx(
            () => getScrollLeftProductController.isLoading.value
                ? const AbsorbPointer(child: ShimmerProductCard())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.43),
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

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.rating,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.kota,
  });

  final String title, description, image, rating, kota;
  final double price;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
        top: 20,
        bottom: 20,
      ),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 217, 220, 231),
          width: 1.1,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(image: image),
          const SizedBox(height: 5),
          Rating(rating: rating),
          const SizedBox(height: 10),
          ProductTitle(title: title),
          const SizedBox(height: 2),
          ProductDescription(description: description),
          const SizedBox(height: 5),
          ProductPrice(price: price),
          const SizedBox(height: 1),
          Flexible(
            // sama dengan Expanded
            fit: FlexFit.tight,
            child: ProductLocation(
              location: kota,
            ),
          ),
          const InkButton(
            text: 'Tambah',
            color: '#519756',
          ),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        maxHeightDiskCache: 300,
        maxWidthDiskCache: 300,
        filterQuality: FilterQuality.low,
        placeholder: (context, url) => Icon(
          Icons.image,
          size: 100,
          color: colorShrink,
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.image,
          size: 100,
          color: colorShrink,
        ),
      ),
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            height: 20,
            width: 45,
            decoration: BoxDecoration(
              color:
                  rating == '0.0000' ? Colors.grey[400] : HexColor('#FFC107'),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.white, size: 10),
                const SizedBox(width: 5),
                Text(
                  rating == '0.0000' ? '0.0' : ('${double.parse(rating)}'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        maxLines: 2,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Text(
        cleanAndCombineText(description),
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        (numberFormat.format(price)),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class ProductLocation extends StatelessWidget {
  const ProductLocation({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon-general/deliver.png',
            height: 20,
            width: 20,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 5),
          Text(
            shortenKabupaten(location.capitalized),
            maxLines: 1,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
