import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/widgets/dashboard/icon_btn_with_counter.dart';
import 'package:sihalal_ecommerce_app/widgets/dashboard/search_field.dart';
import 'package:sihalal_ecommerce_app/main.dart';

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
          const Color.fromARGB(255, 124, 198, 126),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Padding(
        // padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
        padding: EdgeInsets.only(
            left: 20, bottom: 10, top: MediaQuery.of(context).padding.top + 10),
        child: Row(
          children: [
            const SearchField(),
            const SizedBox(width: 10),
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
