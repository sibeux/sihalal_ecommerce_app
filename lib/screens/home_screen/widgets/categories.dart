import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories1 = [
      {
        'icon': "assets/images/icon-category/Sugar-1.png",
        'title': 'Gula',
      },
      {
        'icon': "assets/images/icon-category/flour.png",
        'title': 'Tepung',
      },
      {
        'icon': "assets/images/icon-category/milk.png",
        'title': 'Susu',
      },
      {
        'icon': "assets/images/icon-category/meat.png",
        'title': 'Daging',
      },
      {
        'icon': "assets/images/icon-category/oil.png",
        'title': 'Minyak',
      },
      {
        'icon': "assets/images/icon-category/oil.png",
        'title': 'Minyak',
      },
      {
        'icon': "assets/images/icon-category/oil.png",
        'title': 'Minyak',
      },
      {
        'icon': "assets/images/icon-category/oil.png",
        'title': 'Minyak',
      },
    ];

    List<Map<String, dynamic>> categories2 = [
      {
        'icon': "assets/images/icon-category/bumbu.jpg",
        'title': 'Bumbu',
      },
      {
        'icon': "assets/images/icon-category/santan.jpg",
        'title': 'Santan',
      },
      {
        'icon': "assets/images/icon-category/fish.jpg",
        'title': 'Ikan',
      },
      {
        'icon': "assets/images/icon-category/sirup.jpg",
        'title': 'Sirup',
      },
      {
        'icon': "assets/images/icon-category/salt.jpg",
        'title': 'Garam',
      },
      {
        'icon': "assets/images/icon-category/salt.jpg",
        'title': 'Garam',
      },
      {
        'icon': "assets/images/icon-category/salt.jpg",
        'title': 'Garam',
      },
      {
        'icon': "assets/images/icon-category/salt.jpg",
        'title': 'Garam',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            IconRow(categories: categories1),
            const SizedBox(height: 20),
            IconRow(categories: categories2),
          ],
        ),
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
      child: Container(
        margin: const EdgeInsets.only(right: 20),
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
