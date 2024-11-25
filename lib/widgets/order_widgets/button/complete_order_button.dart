import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/complete_order_dialog.dart';

class CompleteOrderButton extends StatelessWidget {
  const CompleteOrderButton({
    super.key,
    required this.idPesanan,
  });

  final String idPesanan;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            showCompleteOrderDialog(
              idPesanan: idPesanan,
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
              'Terima Pesanan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
