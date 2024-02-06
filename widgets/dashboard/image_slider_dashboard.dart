import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/main_sihalal_app.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/provider/page_indicator_provider.dart';
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
    return Column(
      children: [
        SizedBox(
          // height: 150,
          width: MediaQuery.of(context).size.width,
          child: VxSwiper.builder(
            itemCount: itemCount,
            autoPlay: true,
            height: 200,
            // aspectRatio: 16 / 9,
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
        const SizedBox(
          height: 8,
        ),
        AnimatedSmoothIndicator(
          activeIndex: ref.watch(counterProvider),
          count: itemCount,
          effect: ExpandingDotsEffect(
            activeDotColor: kPrimaryColor,
            dotColor: Colors.grey,
            dotHeight: 4,
            dotWidth: 4,
            spacing: 5,
          ),
        ),
      ],
    );
  }
}
