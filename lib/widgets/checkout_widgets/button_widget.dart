import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';

class ButtonCreateOrder extends StatelessWidget {
  const ButtonCreateOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userAddressController = Get.find<UserAddressController>();
    return Obx(
      () => AbsorbPointer(
        absorbing: userAddressController.addressList.isEmpty ||
            userAddressController.isLoadingGetAddress.value,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: userAddressController.addressList.isEmpty ||
                    userAddressController.isLoadingGetAddress.value
                ? HexColor('#a8b5c8')
                : Colors.white,
            backgroundColor: userAddressController.addressList.isEmpty ||
                    userAddressController.isLoadingGetAddress.value
                ? HexColor('#e5eaf5')
                : ColorPalette().primary,
            elevation: 0, // Menghilangkan shadow
            splashFactory: InkRipple.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(
              double.infinity,
              double.infinity,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            child: Text(
              'Buat Pesanan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
