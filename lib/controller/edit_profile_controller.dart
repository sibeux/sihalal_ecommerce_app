import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:uuid/uuid.dart';

class EditProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var photoUri = ''.obs;
  var oldPhotoUri = '';

  var isInsertImageLoading = false.obs;
  var isImageFileTooLarge = false.obs;
  var isSendingDataLoading = false.obs;
  var isImageChanged = false.obs;

  var nameTextController = TextEditingController();
  var emailTextController = TextEditingController();

  Future<void> insertImage() async {
    final ImagePicker picker = ImagePicker();

    isInsertImageLoading.value = true;

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final size = await pickedFile.length();
      if (size > 2000000) {
        isImageFileTooLarge.value = true;
      } else {
        isImageFileTooLarge.value = false;

        photoUri.value = pickedFile.path;
        isImageChanged.value = true;
      }
    }
    isInsertImageLoading.value = false;
  }

  String generateImageName(String idUser) {
    const uuid = Uuid();

    return "profile_${uuid.v4()}.jpg";
  }

  Future<void> sendChangeProfileData() async {
    isSendingDataLoading.value = true;

    const String url = "https://sibeux.my.id/project/sihalal/user";
    const String imageUploadUrl = 'https://sibeux.my.id/project/sihalal/upload';

    var fileNameImageProfile = '';

    try {
      final requestUploadImage =
          http.MultipartRequest('POST', Uri.parse(imageUploadUrl));

      if (photoUri.isNotEmpty &&
          (!photoUri.value.contains('http') &&
              !photoUri.value.contains('://'))) {
        final userProfileController = Get.find<UserProfileController>();
        fileNameImageProfile =
            generateImageName(userProfileController.userData[0].idUser);
        requestUploadImage.files.add(
          await http.MultipartFile.fromPath(
            // 'file[]' adalah array notation
            // php akan menganggap ini sebagai array
            'file[]',
            photoUri.value,
            filename: fileNameImageProfile,
          ),
        );
      }

      var responseUploadImage =
          http.StreamedResponse(const Stream.empty(), 500);

      if (isImageChanged.value) {
        responseUploadImage = await requestUploadImage.send();
      }

      if (responseUploadImage.statusCode == 200 || !isImageChanged.value) {
        if (isImageChanged.value) {
          debugPrint('Image uploaded');
        }

        final response = await http.post(Uri.parse(url), headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        }, body: {
          'method': 'change_user_data',
          'name': name.value.trim(),
          'email': email.value,
          'photo': isImageChanged.value &&
                  !photoUri.value.contains('http') &&
                  !photoUri.value.contains('://')
              ? 'https://sibeux.my.id/project/sihalal/uploads/$fileNameImageProfile'
              : photoUri.value,
        });

        final responseBody = jsonDecode(response.body);

        if (response.statusCode == 200 && responseBody['status'] == 'success') {
          debugPrint('Data berhasil dikirim: ${response.body}');

          final userProfileController = Get.find<UserProfileController>();
          await userProfileController.getUserData();

          if (photoUri.value != oldPhotoUri) {
            deleteImageFromCpanel();
          }

          Get.back();
        } else {
          debugPrint('Error: ${response.body}');
        }
      } else {
        debugPrint('Error: ${responseUploadImage.reasonPhrase}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isSendingDataLoading.value = false;
    }
  }

  Future<void> deleteImageFromCpanel() async {
    const String imageDeleteUrl = 'https://sibeux.my.id/project/sihalal/delete';

    var fileNameImageProfile = '';

    try {
      if (oldPhotoUri != photoUri.value && oldPhotoUri.isNotEmpty) {
        fileNameImageProfile = oldPhotoUri.split('/').last;
      }

      final response = await http.post(
        Uri.parse(imageDeleteUrl),
        body: jsonEncode({
          'filenames': [fileNameImageProfile],
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      debugPrint(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        debugPrint('Image berhasil dihapus: ${data['message']}');
      } else {
        debugPrint('Image gagal dihapus: ${data['message']}');
      }
    } catch (error) {
      debugPrint('Error deleteImageFromCpanel: $error');
    } finally {}
  }

  bool getIsNameNotValid() {
    final nameValue = name.value;
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.trim().isNotEmpty;
  }

  void setName(String value) {
    name.value = value;
    nameTextController.text = value;
  }

  void setEmail(String value) {
    email.value = value;
    emailTextController.text = value;
  }

  void setPhotoUri(String value) {
    photoUri.value = value;
    oldPhotoUri = value;
  }
}
