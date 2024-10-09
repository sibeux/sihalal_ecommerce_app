import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/address_screen/crud_address_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/address_widgets/address_container.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ListAddressScreen extends StatelessWidget {
  const ListAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userAddressController = Get.put(UserAddressController());
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
            child: Column(
              children: [
                const HeightBox(15),
                Obx(() => userAddressController.isLoadingGetAddress.value
                    ? Expanded(
                        child: Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                            color: ColorPalette().primary,
                            size: 50,
                          ),
                        ),
                      )
                    : userAddressController.addressList.isEmpty
                        ? const SizedBox()
                        : Expanded(
                            child: ListView.builder(
                              itemCount:
                                  userAddressController.addressList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AddressContainer(
                                  index: index,
                                  label: userAddressController
                                      .addressList[index]!.label,
                                  name: userAddressController
                                      .addressList[index]!.name,
                                  phoneNumber: userAddressController
                                      .addressList[index]!.phone,
                                  address: userAddressController
                                      .addressList[index]!.streetAddress,
                                  district: '',
                                  city: userAddressController
                                      .addressList[index]!.city,
                                  province: userAddressController
                                      .addressList[index]!.province,
                                  postalCode: userAddressController
                                      .addressList[index]!.postalCode,
                                  isMain: userAddressController
                                      .addressList[index]!.isPrimary,
                                  isStore: userAddressController
                                      .addressList[index]!.isOffice,
                                );
                              },
                            ),
                          )),
                const HeightBox(5),
                Obx(
                  () => userAddressController.addressList.isEmpty &&
                          !userAddressController.isLoadingGetAddress.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AddressButtonWidget(
                            title: 'Tambah Alamat Baru',
                            icon: Ionicons.add_circle_outline,
                            foregroundColor:
                                ColorPalette().primary.withOpacity(1),
                            backgroundColor: Colors.transparent,
                            onPressed: () {
                              Get.to(
                                () => const CrudAddressScreen(
                                  title: 'Tambah Alamat',
                                ),
                                transition: Transition.rightToLeft,
                                popGesture: false,
                                fullscreenDialog: true,
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
          Obx(
            () => userAddressController.addressList.isNotEmpty
                ? Container(
                    width: double.infinity,
                    height: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
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
                          () => const CrudAddressScreen(
                            title: 'Tambah Alamat',
                          ),
                          transition: Transition.rightToLeft,
                          popGesture: false,
                          fullscreenDialog: true,
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
