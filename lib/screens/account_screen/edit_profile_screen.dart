import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/edit_profile_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/edit_profile_widgets/list_text_field.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/photo_user.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({super.key, required this.name, required this.email});

  final String name, email;

  @override
  Widget build(BuildContext context) {
    final editProfileController = Get.put(EditProfileController());
    editProfileController.setName(name);
    editProfileController.setEmail(email);
    return Scaffold(
      backgroundColor: HexColor('#fafbfb'),
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
        title: const Text('Ubah Profil'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Obx(
            () => AbsorbPointer(
              absorbing: editProfileController.getIsNameNotValid() ||
                  editProfileController.name.value.isEmpty,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: editProfileController.getIsNameNotValid() ||
                              editProfileController.name.value.isEmpty
                          ? Colors.grey
                          : ColorPalette().primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          const HeightBox(60),
          Center(
            child: Transform.scale(
              scale: 2.5,
              child: Stack(
                children: [
                  const UserPhotoAppbar(),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 8,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const HeightBox(60),
          Container(
            width: double.infinity,
            color: HexColor('#f3f2f2').withOpacity(0.5),
            child: Column(
              children: [
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                ),
                ListTextField(
                  title: 'Email',
                  hintText: 'Masukkan Email',
                  controller: editProfileController.emailTextController,
                  stringObs: editProfileController.email,
                  editProfileController: editProfileController,
                ),
                ListTextField(
                  title: 'Nama',
                  hintText: 'Masukkan Nama Lengkap',
                  controller: editProfileController.nameTextController,
                  stringObs: editProfileController.name,
                  editProfileController: editProfileController,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
