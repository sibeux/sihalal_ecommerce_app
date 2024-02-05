import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/main_sihalal_app.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        'icon': Icons.fastfood_outlined,
        'title': 'Bumbu',
      },
      {
        'icon': Icons.outbox_outlined,
        'title': 'Gula',
      },
      {
        'icon': Icons.fastfood,
        'title': 'Tepung',
      },
      {
        'icon': Icons.fastfood,
        'title': 'Minyak',
      },
      {
        'icon': Icons.fastfood,
        'title': 'Garam',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                categories.length,
                (index) => CategoryCard(
                  icon: categories[index]['icon'],
                  text: categories[index]['title'],
                  press: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                categories.length,
                (index) => CategoryCard(
                  icon: categories[index]['icon'],
                  text: categories[index]['title'],
                  press: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final IconData icon;
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
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                  )),
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
