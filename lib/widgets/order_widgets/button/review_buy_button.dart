import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/screens/product_detail_screen/product_detail_screen.dart';

class ReviewBuyButton extends StatelessWidget {
  const ReviewBuyButton({
    super.key,
    required this.statusPesanan,
    required this.idProduct,
    required this.idUser,
    required this.image,
  });

  final String statusPesanan;
  final String idProduct, idUser, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (statusPesanan == 'ulas')
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
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
                  'Lihat Ulasan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(width: 10),
        Flexible(
          fit: statusPesanan == 'ulas' ? FlexFit.tight : FlexFit.loose,
          child: ElevatedButton(
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
              foregroundColor: Colors.white,
              backgroundColor: ColorPalette().primary,
              elevation: 0, // Menghilangkan shadow
              splashFactory: InkRipple.splashFactory,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
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
          ),
        ),
      ],
    );
  }
}
