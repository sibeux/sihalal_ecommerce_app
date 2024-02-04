// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/categories.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/home_header.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/image_slider_dashboard.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/main_sihalal_app.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              SizedBox(height: 10),
              ImageSlider(),
              SizedBox(height: 30),
              Categories(),
            ],
          ),
        ),
      ),
    );
  }
}
