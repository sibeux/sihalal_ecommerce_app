import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/address_screen/list_address_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/review_screen.dart/list_review_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/store_centre_screen.dart';
import 'package:sihalal_ecommerce_app/screens/order_screen/order_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/logout_confirm_modal.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/text_tile.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/photo_user.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, required this.login});

  final bool login;

  @override
  Widget build(BuildContext context) {
    final userLogoutController = Get.put(UserLogoutController());
    final userProfileController = Get.find<UserProfileController>();
    final orderController = Get.find<OrderController>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#fefffe'),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            surfaceTintColor: Colors.transparent,
            backgroundColor: HexColor('#fefffe'),
            toolbarHeight: 50,
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Transform.scale(
                      scale: 1.5,
                      child: const UserPhotoAppbar(),
                    ),
                    const SizedBox(height: 20),
                    if (login)
                      Obx(
                        () => Text(
                          (userProfileController.isLoading.value ||
                                  userProfileController.userData.isEmpty)
                              ? 'Mengambil data...'
                              : userProfileController.userData[0].nameUser,
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 2,
                    ),
                    if (login)
                      Obx(
                        () => Text(
                          (userProfileController.isLoading.value ||
                                  userProfileController.userData.isEmpty)
                              ? 'Mengambil data...'
                              : maskEmail(
                                  userProfileController.userData[0].emailuser),
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    const SizedBox(height: 15),
                    Transform.scale(
                      scale: 0.9,
                      child: login
                          ? const EditProfileButton()
                          : const LoginRegisterProfileButton(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'Pengaturan',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const HeightBox(10),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: HexColor('#f3f2f2').withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: HexColor('#a0a2a0').withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    TextTile(
                      title: 'Toko Saya',
                      icon: Ionicons.storefront_outline,
                      action: () {
                        if (!login) {
                          Get.to(
                            () => const LoginScreen(),
                            transition: Transition.rightToLeft,
                            fullscreenDialog: true,
                            popGesture: false,
                          );
                          return;
                        }
                        Get.to(
                          () => const StoreCentreScreen(),
                          transition: Transition.downToUp,
                          fullscreenDialog: true,
                          popGesture: false,
                        );
                      },
                    ),
                    const SpaceDivider(),
                    TextTile(
                      title: 'Riwayat Pesanan',
                      icon: Ionicons.document_text_outline,
                      action: () {
                        Get.to(
                          () => const OrderScreen(),
                          transition: Transition.downToUp,
                          fullscreenDialog: true,
                          popGesture: false,
                          arguments: {'isFromAccountScreen': true},
                        );
                        orderController.getOrderHistory();
                      },
                    ),
                    const SpaceDivider(),
                    TextTile(
                      title: 'Daftar Alamat',
                      icon: Ionicons.map_outline,
                      action: () {
                        if (!login) {
                          Get.to(
                            () => const LoginScreen(),
                            transition: Transition.rightToLeft,
                            fullscreenDialog: true,
                            popGesture: false,
                          );
                          return;
                        }
                        Get.to(
                          () => const ListAddressScreen(),
                          transition: Transition.downToUp,
                          fullscreenDialog: true,
                          popGesture: false,
                        );
                      },
                    ),
                    const SpaceDivider(),
                    TextTile(
                      title: 'Ulasan',
                      icon: Ionicons.star_outline,
                      action: () {
                        Get.to(
                          () => const ListReviewScreen(),
                          transition: Transition.downToUp,
                          fullscreenDialog: true,
                          popGesture: false,
                        );
                      },
                    ),
                    if (login) const SpaceDivider(),
                    if (login)
                      TextTile(
                        title: 'Keluar',
                        icon: Ionicons.log_out_outline,
                        action: () {
                          showModalConfirmLogout(context);
                        },
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => userLogoutController.isLoggingOut.value ||
                  userProfileController.isLoading.value
              ? const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                )
              : const SizedBox(),
        ),
        Obx(
          () => userLogoutController.isLoggingOut.value ||
                  userProfileController.isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.white,
                    size: 50,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}

class SpaceDivider extends StatelessWidget {
  const SpaceDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: HexColor('#989999').withOpacity(0.4),
          height: 1,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
