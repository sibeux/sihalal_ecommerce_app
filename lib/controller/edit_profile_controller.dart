import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var photoUri = ''.obs;

  var isInsertImageLoading = false.obs;
  var isImageFileTooLarge = false.obs;

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
      }
    }
    isInsertImageLoading.value = false;
  }

  bool getIsNameNotValid() {
    final nameValue = name.value;
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
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
  }
}
