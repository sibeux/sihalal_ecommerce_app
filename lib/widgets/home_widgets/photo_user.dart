import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';

class UserPhotoAppbar extends StatelessWidget {
  const UserPhotoAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UserImage();
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.put(UserProfileController());
    return Obx(
      () => CachedNetworkImage(
        imageUrl: (userProfileController.isLoading.value ||
                userProfileController.userData.isEmpty)
            ? ''
            : userProfileController.userData[0].fotoUser,
        fit: BoxFit.cover,
        height: 35,
        width: 35,
        maxHeightDiskCache: 200,
        maxWidthDiskCache: 200,
        filterQuality: FilterQuality.low,
        placeholder: (context, url) => Image.asset(
          'assets/images/shimmer/profile/profile_shimmer.png',
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/shimmer/profile/profile_shimmer.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
