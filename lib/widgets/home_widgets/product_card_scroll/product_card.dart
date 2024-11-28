import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/left_product_card_scroll.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shimmer_product_card.dart';
import 'package:sihalal_ecommerce_app/component/little_particle.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.rating,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.kota,
    required this.stok,
  });

  final String title, description, image, rating, kota, stok;
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
          ProductImage(image: image, stok: stok),
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
          InkButton(
            text: 'Tambah',
            color: ColorPalette().primary,
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
    required this.stok,
  });

  final String image, stok;

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
      child: Stack(
        children: [
          CachedNetworkImage(
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
          if (stok == '0')
            Container(
              color: Colors.white.withOpacity(0.8),
              alignment: Alignment.center,
              child: Text(
                'Habis',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
        ],
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
          Expanded(
            child: Text(
              shortenKabupaten(location.capitalized),
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
