import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        'icon': "assets/images/icon-category/Sugar-1.png",
        'title': 'Bumbu',
      },
      {
        'icon': "assets/images/icon-category/Sugar-2.png",
        'title': 'Gula',
      },
      {
        'icon': "assets/images/icon-category/Sugar-1.png",
        'title': 'Tepung',
      },
      {
        'icon': "assets/images/icon-category/Sugar-2.png",
        'title': 'Minyak',
      },
      {
        'icon': "assets/images/icon-category/Sugar-1.png",
        'title': 'Garam',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          IconRow(categories: categories),
          const SizedBox(height: 20),
          IconRow(categories: categories),
        ],
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  const IconRow({
    super.key,
    required this.categories,
  });

  final List<Map<String, dynamic>> categories;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
          categories.length,
          (index) => CategoryCard(
            image: categories[index]['icon'],
            text: categories[index]['title'],
            press: () {},
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.image,
    required this.text,
    required this.press,
  });

  final String image;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 55,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                // padding: const EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
