import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductCardRowScroll extends StatelessWidget {
  const ProductCardRowScroll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#B1E9AC'),
      height: 360,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.5),
            const ProductCard(),
            const ProductCard(),
            const ProductCard(),
            const ProductCard(),
            const ProductCard(),
            const ProductCard(),
            const ProductCard(),
            const ProductCard(),
          ],
        ),
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
        top: 25,
        bottom: 25,
      ),
      width: 145,
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
          Container(
            // padding: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            height: 140,
            width: 160,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
            child: Image.network(
                'https://cdn.discordapp.com/attachments/1203953170901110794/1204377726132162611/sliced-green-apple-isolated-white-background_93675-131248.png?ex=65d4832a&is=65c20e2a&hm=e9b3d27691dd93427f432cf2b1f3ffac4d859d3995dfb858ab6c6d0f7de84d0f&',
                fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Container(
              height: 20,
              width: 45,
              decoration: BoxDecoration(
                color: HexColor('##81cc32'),
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 10),
                  SizedBox(width: 5),
                  Text(
                    '4.5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 10),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Text(
                'Wireless Controller for PS4',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const Text(
                'Wireless Controller for PS4',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 10),
            height: 25,
            width: 120,
            decoration: BoxDecoration(
              color: HexColor('#5EC684'),
              borderRadius: BorderRadius.circular(5),
            ),
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
        ],
      ),
    );
  }
}
