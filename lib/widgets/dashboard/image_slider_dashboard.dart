import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/provider/page_indicator_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

List<String> assets = [
  'assets/images/food.jpg',
  'assets/images/food2.jpg',
  'assets/images/food3.jpg',
  'assets/images/food4.jpg',
  'assets/images/food5.jpg'
];

// final _pageController = PageController(initialPage: 0, viewportFraction: 0.95);
const itemCount = 5;

class ImageSlider extends ConsumerStatefulWidget {
  const ImageSlider({
    super.key,
  });

  @override
  ConsumerState<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends ConsumerState<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // height: 150,
          width: MediaQuery.of(context).size.width,
          child: VxSwiper.builder(
            itemCount: itemCount,
            autoPlay: true,
            // height: 200,
            aspectRatio: 16 / 8,
            viewportFraction: 0.95,
            initialPage: 0,
            onPageChanged: (value) {
              ref.watch(counterProvider.notifier).setPage(value);
            },
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.95,
                // width: double.infinity,
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  assets[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          bottom: 15,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSmoothIndicator(
              activeIndex: ref.watch(counterProvider),
              count: itemCount,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.grey.shade200.withOpacity(0.7),
                dotHeight: 4,
                dotWidth: 4,
                expansionFactor: 6,
                spacing: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
