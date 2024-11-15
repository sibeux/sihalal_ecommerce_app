import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/edit_profile_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/edit_profile_widgets/list_text_field.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/edit_profile_widgets/user_photo.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({
    super.key,
    required this.name,
    required this.email,
    required this.photoUri,
  });

  final String name, email, photoUri;

  @override
  Widget build(BuildContext context) {
    final editProfileController = Get.put(EditProfileController());
    editProfileController.setName(name);
    editProfileController.setEmail(email);
    editProfileController.setPhotoUri(photoUri);
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
                  editProfileController.name.value.isEmpty ||
                  editProfileController.name.value.toLowerCase() ==
                      name.toLowerCase() ||
                  editProfileController.isImageFileTooLarge.value,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      color: editProfileController.getIsNameNotValid() ||
                              editProfileController.name.value.isEmpty ||
                              editProfileController.name.value.toLowerCase() ==
                                  name.toLowerCase() ||
                              editProfileController.isImageFileTooLarge.value
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
            child: Stack(
              children: [
                const UserPhoto(),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await editProfileController.insertImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 50,
                left: 50,
                right: 50,
              ),
              decoration: BoxDecoration(
                color: editProfileController.isImageFileTooLarge.value
                    ? const Color.fromARGB(255, 254, 231, 234)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: editProfileController.isImageFileTooLarge.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: HexColor('#cd7a7d'),
                          size: 15,
                        ),
                        const WidthBox(5),
                        Text(
                          'Maksimal ukuran gambar 2 MB',
                          style: TextStyle(
                            color: HexColor('#cd7a7d'),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
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
