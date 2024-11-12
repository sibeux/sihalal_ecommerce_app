import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/address_screen/crud_address_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/address_screen/list_address_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userAddressController = Get.put(UserAddressController());

    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Pengiriman',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                const HeightBox(5),
                Row(
                  children: [
                    Icon(
                      Ionicons.location_sharp,
                      color: ColorPalette().primary,
                      size: 18,
                    ),
                    const WidthBox(5),
                    Obx(
                      () => userAddressController.isLoadingGetAddress.value
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Text(
                                  'M Nasrul Wahabi | (+62) 81234567890',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : userAddressController.addressList.isEmpty
                              ? InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => const CrudAddressScreen(
                                        title: 'Tambah Alamat',
                                      ),
                                      transition: Transition.rightToLeft,
                                      popGesture: false,
                                      fullscreenDialog: true,
                                    );
                                  },
                                  child: Text(
                                    'Tambah Alamat',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: ColorPalette().primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : NamePhoneSelected(
                                  userAddressController: userAddressController,
                                ),
                    ),
                  ],
                ),
                const HeightBox(5),
                Obx(
                  () => userAddressController.isLoadingGetAddress.value
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Jl. Raya Cipadu No. 1, RT 01/01, Cipadu, Ciledug, Tangerang, Banten, 15151',
                              style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      : userAddressController.addressList.isEmpty
                          ? const Text(
                              'Harap tambahkan alamat pengiriman terlebih dahulu',
                              style: TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w200,
                              ),
                            )
                          : CityStreetSelected(
                              userAddressController: userAddressController,
                            ),
                ),
              ],
            ),
          ),
          const WidthBox(15),
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              if (userAddressController.addressList.isEmpty) {
                Get.to(
                  () => const CrudAddressScreen(
                    title: 'Tambah Alamat',
                  ),
                  transition: Transition.rightToLeft,
                  popGesture: false,
                  fullscreenDialog: true,
                );
              } else {
                Get.to(
                  () => const ListAddressScreen(),
                  transition: Transition.rightToLeft,
                  popGesture: false,
                  fullscreenDialog: true,
                  
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black.withOpacity(0.5),
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NamePhoneSelected extends StatelessWidget {
  const NamePhoneSelected({
    super.key,
    required this.userAddressController,
  });

  final UserAddressController userAddressController;

  @override
  Widget build(BuildContext context) {
    final adress = userAddressController.addressList
        .where((element) => element!.isPrimary);
    final name = adress.first!.name;
    final phone = adress.first!.phone;
    return Text(
      '$name | (+62) $phone',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w800,
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }
}

class CityStreetSelected extends StatelessWidget {
  const CityStreetSelected({
    super.key,
    required this.userAddressController,
  });

  final UserAddressController userAddressController;
  @override
  Widget build(BuildContext context) {
    final address = userAddressController.addressList
        .where((element) => element!.isPrimary);
    final street = address.first!.streetAddress;
    final city = address.first!.city;
    final province = address.first!.province;
    final postalCode = address.first!.postalCode;
    return Text(
      '$street, $city, $province, $postalCode',
      maxLines: 1,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.5),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
