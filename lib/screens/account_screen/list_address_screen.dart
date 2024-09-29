import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
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
      body: const Column(
        children: [
          Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          HeightBox(15),
          AddressContainer(
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
          AddressContainer(
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
          HeightBox(10),
          AddNewAddress(),
        ],
      ),
    );
  }
}
