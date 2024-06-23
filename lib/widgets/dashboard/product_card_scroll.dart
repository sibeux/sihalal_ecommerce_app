import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/provider/product_card_provider.dart';
import 'package:sihalal_ecommerce_app/widgets/little_particle.dart';
import 'package:sihalal_ecommerce_app/widgets/shrink_tap_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

NumberFormat numberFormat =
    NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

final Shader linearGradient = LinearGradient(
  colors: <Color>[HexColor("1D6BFF"), HexColor("C125FF")],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class ProductCardRowScroll extends ConsumerWidget {
  const ProductCardRowScroll({
    super.key,
    required this.color,
    required this.cardHeader,
  });

  final String color;
  final String cardHeader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyProductCard = ref.watch(productCardProvider_1);

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
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.values[5],
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
                      color: Colors.green,
                      fontSize: 15,
                      fontWeight: FontWeight.values[5],
                    ),
                  )),
            )
          ],
        ),
        const SizedBox(height: 15),
        Container(
          height: 370,
          decoration: BoxDecoration(
            color: HexColor(color),
            image: const DecorationImage(
              alignment: AlignmentDirectional.centerStart,
              fit: BoxFit.fitHeight,
              image: NetworkImage(
                  "https://cdn.discordapp.com/attachments/1203953170901110794/1205086820577185812/Mask_group.png?ex=65d7178f&is=65c4a28f&hm=97b5b85283c8e36ebdcf30d8d991a4f5ad37a64508f233b631528cafc20b6695&"),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.43),
                // create for each product card from dummyProductCard
                for (var product in dummyProductCard)
                  ShrinkCardProduct(
                    title: product.title,
                    description: product.description,
                    price: product.price,
                    rating: product.rating,
                    image: product.image,
                  ),
                const SizedBox(width: 10),
              ],
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
  });

  final String title, description, image;
  final double rating, price;

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
          const InkButton(
            text: 'Tambah',
            color: '#5EC684',
          ),
        ],
      ),
    );
  }
}

class NoHalal extends StatelessWidget {
  const NoHalal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.discordapp.com/attachments/1203953170901110794/1205115624225898516/logo_halal.png?ex=65d73262&is=65c4bd62&hm=be8496e1908f66bbe78c0bbcf6b8dfffd39c2b65ce24c41c3ce9f8b2b636f0c7&"),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 25,
            alignment: Alignment.centerLeft,
            // color: Colors.amber.withOpacity(0.8),
            margin: const EdgeInsets.only(
              right: 10,
              left: 5,
            ),
            child: Text(
              "ID00410000088710720",
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  foreground: Paint()..shader = linearGradient),
            ),
          ),
        ),
      ],
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
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          (numberFormat.format(price)),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
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
    return Container(
      // padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final double rating;

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
              color: HexColor('##81cc32'),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.white, size: 10),
                const SizedBox(width: 5),
                Text(
                  rating.toString(),
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
        description,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
      ),
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
