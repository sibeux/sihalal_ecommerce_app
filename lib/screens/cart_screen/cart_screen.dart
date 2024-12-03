import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Keranjang'),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 0.4,
            thickness: 0.4,
          ),
          const HeightBox(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.asset('assets/images/icon-general/cart.png'),
                  ),
                ),
                const WidthBox(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keranjang belanja anda masih kosong',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black.withOpacity(1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const HeightBox(10),
                      Text(
                        'Yuk, belanja sekarang!',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const HeightBox(20),
        ],
      ),
    );
  }
}
