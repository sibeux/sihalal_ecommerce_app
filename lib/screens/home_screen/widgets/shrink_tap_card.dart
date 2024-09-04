import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:sihalal_ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/product_card_scroll.dart';

double colorOnTap = 1;

class ShrinkTapProduct extends StatefulWidget {
  const ShrinkTapProduct({
    super.key,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
    required this.image,
    required this.uid,
    required this.product,
  });

  final String uid, title, description, image, rating;
  final double price;
  final Product product;

  @override
  ShrinkTapProductState createState() => ShrinkTapProductState();
}

class ShrinkTapProductState extends State<ShrinkTapProduct>
    with SingleTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 100;

  double _scaleTransformValue = 1;

  // needed for the "click" tap effect
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() => _scaleTransformValue = 1 - animationController.value);
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _shrinkButtonSize() {
    animationController.forward();

    colorOnTap = 0.5;
  }

  void _restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
    colorOnTap = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _shrinkButtonSize();
        _restoreButtonSize();
        Get.to(() => DetailProductScreen(product: widget.product));
      },
      onPanDown: (_) {
        _shrinkButtonSize();
      },
      onPanEnd: (_) {
        _restoreButtonSize();
      },
      onPanCancel: () => _restoreButtonSize(),
      child: Transform.scale(
        scale: _scaleTransformValue,
        child: SizedBox(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 10,
                  top: 20,
                  bottom: 20,
                ),
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Opacity(
                opacity: colorOnTap,
                child: ProductCard(
                  title: widget.title,
                  description: widget.description,
                  rating: widget.rating,
                  price: widget.price,
                  image: widget.image,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
