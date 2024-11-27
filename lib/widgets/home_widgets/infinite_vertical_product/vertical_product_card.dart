import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/product_card_scroll.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shimmer_product_card.dart';
import 'package:velocity_x/velocity_x.dart';

class VerticalProductCard extends ConsumerWidget {
  const VerticalProductCard({
    super.key,
    required this.rating,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.kota,
    required this.index,
  });

  final String title, description, image, rating, kota;
  final double price;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(
        left: index % 2 == 0 ? 17 : 5,
        right: index % 2 == 0 ? 5 : 17,
        top: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductImage(image: image),
            const SizedBox(height: 5),
            ProductRating(rating: rating),
            const SizedBox(height: 5),
            ProductTitle(title: title),
            const SizedBox(height: 2),
            ProductDescription(description: description),
            const SizedBox(height: 5),
            ProductPrice(price: price),
            const SizedBox(height: 1),
            ProductLocation(
              location: kota,
            ),
            const SizedBox(height: 10),
          ],
        ),
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
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
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
      ),
    );
  }
}

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // margin: const EdgeInsets.only(right: 10),
          height: 20,
          width: 45,
          decoration: BoxDecoration(
            color: rating == '0.0000' ? Colors.grey[400] : HexColor('#FFC107'),
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
          ),
        ),
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
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        maxLines: 2,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
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
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Text(
        cleanAndCombineText(description),
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 11,
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
      // margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        (numberFormat.format(price)),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
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
      // margin: const EdgeInsets.symmetric(horizontal: 10),
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
