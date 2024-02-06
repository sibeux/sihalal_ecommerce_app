import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/little_particle.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

NumberFormat numberFormat =
    NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);

class ProductCardRowScroll extends StatelessWidget {
  const ProductCardRowScroll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      decoration: BoxDecoration(
        color: HexColor('#B1E9AC'),
        image: const DecorationImage(
          alignment: AlignmentDirectional.centerStart,
          fit: BoxFit.fitHeight,
          image: NetworkImage(
            'https://cdn.discordapp.com/attachments/1203953170901110794/1204478598937837668/Mask_group.png?ex=65d4e11c&is=65c26c1c&hm=d2a550b891dab02a821e2f24e88026103acec9f2aff679879c86203a10df5a2d&',
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.43),
            const ProductCard(
              title: 'Sweet apple ',
              subtitle: '12 pieces per 1kg',
              rating: 3.5,
              price: 12000,
            ),
            const ProductCard(
              title: 'Sweet apple with green label and red apple',
              subtitle: '12 pieces per 1kg and 6 pieces per 1kg',
              rating: 4.5,
              price: 12000,
            ),
            const ProductCard(
              title: 'Sweet apple ',
              subtitle: '12 pieces per 1kg',
              rating: 4.5,
              price: 12000,
            ),
            const ProductCard(
              title: 'Sweet apple with green label',
              subtitle: '12 pieces per 1kg',
              rating: 3.5,
              price: 1500000,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.rating,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  final double rating;
  final String title;
  final String subtitle;
  final double price;

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
          const ProductImage(),
          const SizedBox(height: 5),
          Rating(rating: rating),
          const SizedBox(height: 10),
          ProductTitle(title: title),
          const SizedBox(height: 2),
          ProductSubtitle(subtitle: subtitle),
          const SizedBox(height: 10),
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
        child: Text((numberFormat.format(price)),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
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
      height: 140,
      width: 160,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      )),
      child: Image.network(
          'https://cdn.discordapp.com/attachments/1203953170901110794/1204377726132162611/sliced-green-apple-isolated-white-background_93675-131248.png?ex=65d4832a&is=65c20e2a&hm=e9b3d27691dd93427f432cf2b1f3ffac4d859d3995dfb858ab6c6d0f7de84d0f&',
          fit: BoxFit.cover),
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

class ProductSubtitle extends StatelessWidget {
  const ProductSubtitle({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.topLeft,
      child: Text(
        subtitle,
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
