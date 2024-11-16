import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/edit_profile_controller.dart';

void confirmDialog() {
  Get.dialog(
    name: 'confirmDialog',
    AlertDialog(
      backgroundColor: HexColor('#fefffe'),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      actionsPadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 10,
      ),
      content: Text(
        'Yakin untuk menyimpan perubahan?',
        style: TextStyle(
          fontSize: 13,
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            const Divider(
              height: 0.4,
              thickness: 0.4,
            ),
            SizedBox(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Batalkan',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // *** verticalDivider baru muncul jika row di-wrap sizebox + height
                  // Intinya tinggi harus diatur
                  const VerticalDivider(
                    width: 0.9,
                    thickness: 0.9,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        final editProfileController = Get.find<EditProfileController>();
                        await editProfileController.sendChangeProfileData();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Konfirmasi',
                          style: TextStyle(
                            color: ColorPalette().primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}
