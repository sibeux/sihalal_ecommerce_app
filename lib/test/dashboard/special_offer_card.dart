import 'package:flutter/material.dart';

class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({super.key});

  @override
  State<SpecialOfferCard> createState() => _SpecialOfferCardState();
}

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  final List<String> image = [
    'https://cdn.discordapp.com/attachments/975298274917482556/1203953170641068112/Mask_group.png?ex=65d2f7c4&is=65c082c4&hm=85e804f5892dc0450ee2d9c3fd991e4b48c44ef6575d07eb02f195e812f2a874&',
    'https://cdn.discordapp.com/attachments/1203953170901110794/1203971188184059915/Mask_group_1.png?ex=65d3088b&is=65c0938b&hm=c127efcdc4780d56b7fb4dcd79cf591f96fa2ec69cceb745ccf191846d16949a&',
    'https://cdn.discordapp.com/attachments/1203953170901110794/1203971188410548266/Mask_group.png?ex=65d3088c&is=65c0938c&hm=c8bcc1fab9f847ac6bbbdf351c703c08d23d7bec6642bbbbef2502b71a0239c4&',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        height: 300,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OfferingCard(image: image[0]),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  OfferingCard(image: image[2]),
                  const SizedBox(height: 10),
                  OfferingCard(image: image[1]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfferingCard extends StatelessWidget {
  const OfferingCard({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(255, 217, 220, 231),
            width: 1.2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
