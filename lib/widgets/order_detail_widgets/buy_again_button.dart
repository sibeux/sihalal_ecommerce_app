import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/screens/product_detail_screen/product_detail_screen.dart';

class BuyAgainButton extends StatelessWidget {
  const BuyAgainButton({
    super.key,
    required this.idProduct,
    required this.idUser,
    required this.image,
  });

  final String idProduct, idUser, image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(
          () => ProductDetailScreen(
            idProduk: idProduct,
            idUser: idUser,
            fotoImage1: image,
          ),
          transition: Transition.downToUp,
          fullscreenDialog: true,
          popGesture: false,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorPalette().primary,
        backgroundColor: Colors.transparent,
        elevation: 0, // Menghilangkan shadow
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: ColorPalette().primary,
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        child: Text(
          'Beli Lagi',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
