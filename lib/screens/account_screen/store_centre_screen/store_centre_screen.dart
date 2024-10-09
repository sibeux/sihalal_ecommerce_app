import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/list_address_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/photo_user.dart';
import 'package:velocity_x/velocity_x.dart';

class StoreCentreScreen extends StatelessWidget {
  const StoreCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
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
        title: const Text('Toko Saya'),
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
          const HeightBox(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Transform.translate(
                  offset: const Offset(20, 0),
                  child: Transform.scale(
                    scale: 2,
                    child: const UserPhotoAppbar(),
                  ),
                ),
                const WidthBox(50),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfileController.userData[0].nameShop == ''
                            ? 'Toko ${userProfileController.userData[0].nameUser}'
                            : userProfileController.userData[0].nameShop,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(1),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => userAddressController.isLoadingGetAddress.value
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: const Text(
                                  'Lihat Toko Saya',
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (userAddressController
                                      .addressList.isEmpty) {
                                    Get.to(
                                      () => const ListAddressScreen(),
                                      transition: Transition.rightToLeft,
                                      fullscreenDialog: true,
                                      popGesture: false,
                                    );
                                  }
                                },
                                child: Text(
                                  (userAddressController.addressList.isEmpty)
                                      ? 'Tambahkan Alamat Toko'
                                      : userAddressController.addressList
                                              .firstWhere((element) =>
                                                  element!.isStore == true)
                                              ?.city ??
                                          '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: userAddressController
                                            .addressList.isEmpty
                                        ? ColorPalette().primary
                                        : Colors.black.withOpacity(0.6),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
                const WidthBox(15),
                Icon(
                  Icons.edit_square,
                  color: ColorPalette().primary,
                  size: 18,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: HexColor('#eff4f8'),
            height: 8,
            thickness: 8,
          ),
        ],
      ),
    );
  }
}
