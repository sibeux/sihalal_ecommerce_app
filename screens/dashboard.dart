import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/categories.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/home_header.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/image_slider_dashboard.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/special_offer_card.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/little_particle.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    ImageSlider(),
                    SizedBox(height: 30),
                    Categories(),
                    SizedBox(height: 20),
                    GreyLined(),
                    SizedBox(height: 30),
                    SpecialOfferCard(),
                    SizedBox(height: 30),
                    GreyLined(),
                    SizedBox(height: 30),
                    ProductCardRowScroll(),
                    SizedBox(height: 30),
                    GreyLined(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCardRowScroll extends StatelessWidget {
  const ProductCardRowScroll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 350,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 20),
            ProductCard(),
            ProductCard(),
            ProductCard(),
            ProductCard(),
            ProductCard(),
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
        top: 5,
        bottom: 5,
      ),
      width: 145,
      decoration: BoxDecoration(
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
            ),
            child: Image.network(
                'https://cdn.discordapp.com/attachments/1203953170901110794/1204005142370721792/Mask_group.png?ex=65d3282b&is=65c0b32b&hm=689b1c388710d978fdf0b64ea073f7d08c9cdb0bc1c8b117e61d61b3a1fdf728&',
                fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          const Text(
            'Wireless Controller for PS4',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          const Text(
            '\$64.99',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
