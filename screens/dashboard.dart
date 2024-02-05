// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/categories.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/home_header.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/image_slider_dashboard.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/little_particle.dart';
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
                    PromoCardPortrait(),
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

class PromoCardPortrait extends StatefulWidget {
  const PromoCardPortrait({super.key});

  @override
  State<PromoCardPortrait> createState() => _PromoCardPortraitState();
}

class _PromoCardPortraitState extends State<PromoCardPortrait> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
