import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final colorShrink = Colors.grey[300];

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.43),
          // create for each product card from dummyProductCard
          for (var x = 0; x < 5; x++) const ProductCard(),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const ProductImage()),
          const SizedBox(height: 5),
          const Rating(rating: 0.0),
          const SizedBox(height: 10),
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const ProductTitle()),
          const SizedBox(height: 8),
          Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: const ProductDescription()),
          const SizedBox(height: 5),
          const ProductPrice(),
          const InkButtonShrink(),
        ],
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
  });

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
      child: Icon(
        Icons.image,
        size: 100,
        color: colorShrink,
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
              color: Colors.grey,
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

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: Container(
                height: 15,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorShrink,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: Container(
                height: 15,
                decoration: BoxDecoration(
                  color: colorShrink,
                ),
              ),
            )
          ],
        ));
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.topLeft,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(3)),
          child: Container(
            height: 15,
            decoration: BoxDecoration(
              color: colorShrink,
            ),
          ),
        ));
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              child: Container(
                decoration: BoxDecoration(
                  color: colorShrink,
                ),
              ),
            )),
      ),
    );
  }
}

class InkButtonShrink extends StatelessWidget {
  const InkButtonShrink({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            'Tambah',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
