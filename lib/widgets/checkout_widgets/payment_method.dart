import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';

enum PaymentMethodEnum { cod }

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metode Pembayaran',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
          const HeightBox(5),
          ListTile(
            leading: Icon(
              Ionicons.cash_outline,
              color: Colors.amber.withOpacity(0.7),
            ),
            title: Text(
              'Bayar di Tempat (COD)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            minLeadingWidth: 0,
            horizontalTitleGap: 10,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            trailing: Radio<PaymentMethodEnum>(
              activeColor: ColorPalette().primary,
              value: PaymentMethodEnum.cod,
              groupValue: PaymentMethodEnum.cod,
              onChanged: (PaymentMethodEnum? value) {},
            ),
          ),
        ],
      ),
    );
  }
}
