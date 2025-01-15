import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/screens/product_detail_screen/product_detail_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/left_product_card_scroll.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shimmer_product_card.dart';
import 'package:velocity_x/velocity_x.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({
    super.key,
    required this.idProduct,
    required this.idUser,
    required this.rating,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.kota,
    required this.isFavorite,
    required this.screenFrom,
    required this.stok,
  });

  final String idProduct, idUser;
  final String title, description, image, rating, kota, stok;
  final double price;
  final bool isFavorite;
  final String screenFrom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Get.to(
            () => ProductDetailScreen(
              idProduk: idProduct,
              idUser: idUser,
              fotoImage1: image,
              screenFrom: screenFrom,
            ),
            transition: Transition.native,
            fullscreenDialog: true,
            popGesture: false,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductImage(image: image, stok: stok),
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
    required this.stok,
  });

  final String image, stok;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Stack(
          children: [
            Center(
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
            if (stok == '0')
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white.withOpacity(0.9),
                child: const Text(
                  'Produk habis',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ).centered(),
              ),
          ],
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
    String rating = NumberFormat("0.0").format(double.parse(this.rating));
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          // margin: const EdgeInsets.only(right: 10),
          height: 20,
          width: 45,
          decoration: BoxDecoration(
            color: this.rating == '0.0000'
                ? Colors.grey[400]
                : HexColor('#FFC107'),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.white, size: 10),
              const SizedBox(width: 5),
              Text(
                this.rating == '0.0000' ? '0.0' : rating,
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
