import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/cancel_order_dialog.dart';

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton({super.key, required this.idPesanan});

  final String idPesanan;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            showCancelOrderDialog(
              idPesanan: idPesanan,
              statusPesanan: 'batal',
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.transparent,
            elevation: 0, // Menghilangkan shadow
            splashFactory: InkRipple.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 10.0,
            ),
            child: Text(
              'Batalkan Pesanan',
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
