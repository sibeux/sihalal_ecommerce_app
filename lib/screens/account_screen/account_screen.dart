import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/logout_confirm_modal.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userLogoutController = Get.put(UserLogoutController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#fefffe'),
          body: Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text('Akun'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showModalConfirmLogout(context);
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
        Obx(() => userLogoutController.isLoggingOut.value
            ? const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              )
            : const SizedBox()),
        Obx(() => userLogoutController.isLoggingOut.value
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 50,
                ),
              )
            : const SizedBox()),
      ],
    );
  }
}
