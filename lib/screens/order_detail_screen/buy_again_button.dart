import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';

class BuyAgainButton extends StatelessWidget {
  const BuyAgainButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        
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
