import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/new_address_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/address_container.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ListAddressScreen extends StatelessWidget {
  const ListAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Daftar Alamat'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeightBox(15),
                  for (int i = 0; i < 0; i++)
                    const AddressContainer(
                      label: 'kantor',
                      name: 'Nasrul Wahabi',
                      phoneNumber: '081234567890',
                      address: 'Jl. Raya Cipadu No. 1',
                      district: 'Cipadu',
                      city: 'Tangerang',
                      province: 'Banten',
                      postalCode: '15148',
                      isMain: true,
                      isStore: false,
                    ),
                  for (int i = 0; i < 2; i++)
                    const AddressContainer(
                      label: 'rumah',
                      name: 'Wahabi Sibe',
                      phoneNumber: '081234567890',
                      address: 'Jl. Raya Cipadu No. 1',
                      district: 'Cipadu',
                      city: 'Tangerang',
                      province: 'Banten',
                      postalCode: '15148',
                      isMain: false,
                      isStore: true,
                    ),
                  const HeightBox(5),
                  if (true)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AddressButtonWidget(
                        title: 'Tambah Alamat Baru',
                        icon: Ionicons.add_circle_outline,
                        foregroundColor: ColorPalette().primary.withOpacity(1),
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          Get.to(
                            () => const NewAddressScreen(),
                            transition: Transition.rightToLeft,
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          ),
          if (true)
            Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              decoration: BoxDecoration(
                color: HexColor('#fefeff'),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: AddressButtonWidget(
                title: 'Tambah Alamat Baru',
                icon: Ionicons.add_circle_outline,
                foregroundColor: ColorPalette().primary.withOpacity(1),
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Get.to(
                    () => const NewAddressScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
