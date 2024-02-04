import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List<String> assets = [
  'assets/images/food.jpg',
  'assets/images/food2.jpg',
  'assets/images/food3.jpg',
  'assets/images/food4.jpg',
  'assets/images/food5.jpg'
];

int currentindex = 0;

final _pageController = PageController(initialPage: 0, viewportFraction: 0.92);

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: 5,
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (value) {
              currentindex = value;
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    //  color: color[index],
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  assets[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: 5,
          effect: const ExpandingDotsEffect(
            activeDotColor: Color.fromARGB(255, 0, 169, 88),
            dotColor: Colors.grey,
            dotHeight: 7,
            dotWidth: 7,
            spacing: 5,
          ),
        )
      ],
    );
  }
}
