import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/edit_profile_controller.dart';

class UserPhoto extends StatelessWidget {
  const UserPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileController = Get.find<EditProfileController>();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: HexColor('#a0a2a0').withOpacity(0.3),
            width: 1,
          ),
        ),
        child: editProfileController.isInsertImageLoading.value
            ? const SizedBox(
                height: 90,
                width: 90,
                child: CupertinoActivityIndicator(),
              )
            : (editProfileController.photoUri.value.contains('http') &&
                        editProfileController.photoUri.value.contains('://')) ||
                    editProfileController.photoUri.value.isEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: editProfileController.photoUri.value,
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                      maxHeightDiskCache: 300,
                      maxWidthDiskCache: 300,
                      filterQuality: FilterQuality.medium,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/shimmer/profile/profile_shimmer.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/shimmer/profile/profile_shimmer.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      File(editProfileController.photoUri.value),
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
      ),
    );
  }
}
