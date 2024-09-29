import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:velocity_x/velocity_x.dart';

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    super.key,
    required this.label,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.district,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.isMain,
    required this.isStore,
  });

  final String label,
      name,
      phoneNumber,
      address,
      district,
      city,
      province,
      postalCode;
  final bool isMain, isStore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: HexColor('#000000').withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    label == 'kantor'
                        ? Ionicons.business_outline
                        : Ionicons.home_outline,
                    color: HexColor('#000000'),
                    size: 22,
                  ),
                  const WidthBox(10),
                  Text(
                    label.capitalized,
                    style: TextStyle(
                      color: HexColor('#000000'),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const WidthBox(10),
              if (isMain)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: ColorPalette().primary.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Utama',
                    style: TextStyle(
                      color: HexColor('#ffffff'),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (isStore)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Alamat Toko',
                    style: TextStyle(
                      color: HexColor('#000000').withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const HeightBox(5),
          Text(
            name,
            style: TextStyle(
              color: HexColor('#000000'),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const HeightBox(5),
          Text(
            '(+62) $phoneNumber',
            style: TextStyle(
              color: HexColor('#000000').withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const HeightBox(20),
          Text(
            address,
            style: TextStyle(
              color: HexColor('#000000').withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const HeightBox(5),
          Text(
            '$district, $city, $province',
            style: TextStyle(
              color: HexColor('#000000').withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const HeightBox(5),
          Text(
            postalCode,
            style: TextStyle(
              color: HexColor('#000000').withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
