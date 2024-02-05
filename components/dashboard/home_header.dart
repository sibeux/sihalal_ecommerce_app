import 'package:flutter/material.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/icon_btn_with_counter.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/components/dashboard/search_field.dart';
import 'package:flutter_mobile/SiHALAL-ecommerce-app/main_sihalal_app.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          kPrimaryColor,
          Colors.green.shade300,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            const SearchField(),
            const SizedBox(
              width: 10,
            ),
            IconBtnWithCounter(
              iconBar: Icons.shopping_cart_rounded,
              numOfItems: 3,
              press: () {},
            ),
            IconBtnWithCounter(
              iconBar: Icons.message_rounded,
              numOfItems: 3,
              press: () {},
            ),
            IconBtnWithCounter(
              iconBar: Icons.menu,
              numOfItems: 0,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
