import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/address_screen/list_address_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/photo_user.dart';
import 'package:velocity_x/velocity_x.dart';

class StoreInfo extends StatelessWidget {
  const StoreInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    final userAddressController = Get.put(UserAddressController());
    return Container(
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Lihat Toko Saya',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (userAddressController.addressList.isEmpty) {
                              Get.to(
                                () => const ListAddressScreen(),
                                transition: Transition.rightToLeft,
                                fullscreenDialog: true,
                                popGesture: false,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Atur alamat toko di halaman alamat',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                textColor: Colors.white,
                                fontSize: 10.0,
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
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: userAddressController.addressList.isEmpty
                                  ? ColorPalette().primary
                                  : Colors.black.withOpacity(0.6),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                ),
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
    );
  }
}
