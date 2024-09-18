import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<String> assets = [
  'assets/images/food.jpg',
  'assets/images/food2.jpg',
  'assets/images/food3.jpg',
  'assets/images/food4.jpg',
  'assets/images/food5.jpg'
];

int currentindex = 0;

final _pageController = PageController(initialPage: 0, viewportFraction: 0.95);

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (value) {
              currentindex = value;
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    //  color: color[index],
                    borderRadius: BorderRadius.circular(8)),
                child: Image.asset(
                  assets[index % 5],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: 5,
          effect: ExpandingDotsEffect(
            activeDotColor: HexColor('#8D1EE4'),
            dotColor: Colors.grey,
            expansionFactor: 5,
            dotHeight: 4,
            dotWidth: 4,
            spacing: 5,
          ),
        )
      ],
    );
  }
}
