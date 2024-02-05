// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/categories.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/home_header.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/image_slider_dashboard.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/dashboard/special_offer_card.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/widgets/little_particle.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/main_sihalal_app.dart';

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
