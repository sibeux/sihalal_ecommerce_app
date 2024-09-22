
import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/test/dashboard/home_header.dart';
import 'package:sihalal_ecommerce_app/test/dashboard/image_slider_dashboard.dart';
import 'package:sihalal_ecommerce_app/test/dashboard/special_offer_card.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/categories.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // * harusnya ini body-nya pake safearea, tapi karena biar
      // * lebih mudah maintain warna header, jadi ga pake safearea
      body: Column(
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
                  SizedBox(height: 30),
                  SpecialOfferCard(),
                  SizedBox(height: 40),
                  ProductCardRowScroll(
                    color: '#B1E9AC',
                    cardHeader: "Cek Produk Terbaru di SiHALAL",
                    sort: 'recent',
                  ),
                  SizedBox(height: 40),
                  ProductCardRowScroll(
                    color: '#FE5959',
                    cardHeader: 'Kebutuhan Masakan Kamu',
                    sort: 'popular',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
