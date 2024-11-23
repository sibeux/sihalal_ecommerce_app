import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/alert_modal_dialog/confirm_order_dialog.dart';

class StoreConfirmOrderButton extends StatelessWidget {
  const StoreConfirmOrderButton({super.key, required this.idPesanan});

  final String idPesanan;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        confirmOrderDialog(context, idPesanan);
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
          'Konfirmasi',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
