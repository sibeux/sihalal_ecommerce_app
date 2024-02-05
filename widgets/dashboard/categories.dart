import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        'icon':
            "https://cdn.discordapp.com/attachments/1203953170901110794/1203986631217127425/burger_14x.png?ex=65d316ed&is=65c0a1ed&hm=b97235ef82c29c03ef3609f20cf4e68cdc2a07d280b6711e92b44e54306c0f52&",
        'title': 'Bumbu',
      },
      {
        'icon':
            "https://cdn.discordapp.com/attachments/1203953170901110794/1203988315448021082/Asset_34x.png?ex=65d3187f&is=65c0a37f&hm=eee482a6752583242da55c1806780e6cc9fc1fb5120dda69336faedeb8d3dff1&",
        'title': 'Gula',
      },
      {
        'icon':
            "https://cdn.discordapp.com/attachments/1203953170901110794/1203978989232852992/Asset_14x.png?ex=65d30fcf&is=65c09acf&hm=5ba8991b468cfe5015776d0813326d0b81690e63ce538550d95f431bdeabe7a1&",
        'title': 'Tepung',
      },
      {
        'icon':
            "https://cdn.discordapp.com/attachments/1203953170901110794/1203978989232852992/Asset_14x.png?ex=65d30fcf&is=65c09acf&hm=5ba8991b468cfe5015776d0813326d0b81690e63ce538550d95f431bdeabe7a1&",
        'title': 'Minyak',
      },
      {
        'icon':
            "https://cdn.discordapp.com/attachments/1203953170901110794/1203978989232852992/Asset_14x.png?ex=65d30fcf&is=65c09acf&hm=5ba8991b468cfe5015776d0813326d0b81690e63ce538550d95f431bdeabe7a1&",
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
                  image: categories[index]['icon'],
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
                  image: categories[index]['icon'],
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
                child: Image.network(
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
