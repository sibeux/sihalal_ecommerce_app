import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/edit_profile_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ListTextField extends StatelessWidget {
  const ListTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.stringObs,
    required this.hintText,
    required this.editProfileController,
  });

  final String title, hintText;
  final TextEditingController controller;
  final RxString stringObs;
  final EditProfileController editProfileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeightBox(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: TextFormField(
                  enabled: title.toLowerCase() == 'email' ? false : true,
                  autofillHints:
                      title.toLowerCase() == 'nama' ? ['name'] : null,
                  controller: controller,
                  onChanged: (value) {
                    stringObs.value = value;
                  },
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  style: TextStyle(
                    color: title.toLowerCase() == 'email'
                        ? Colors.grey
                        : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  maxLength: 225,
                  buildCounter: (context,
                      {int? currentLength, int? maxLength, bool? isFocused}) {
                    return null; // Menghilangkan teks maxLength
                  },
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Masukkan Nama Lengkap',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const WidthBox(5),
              Obx(
                () => stringObs.value.isEmpty || title.toLowerCase() == 'email'
                    ? const SizedBox(
                        width: 20,
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.clear();
                          stringObs.value = '';
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
              ),
            ],
          ),
        ),
        Obx(
          () => editProfileController.getIsNameNotValid() &&
                  title.toLowerCase() == 'nama'
              ? Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    '*Nama tidak boleh mengandung angka atau simbol',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        const HeightBox(10),
        Obx(
          () => Divider(
            height: 0.5,
            thickness: 0.5,
            color: editProfileController.getIsNameNotValid() &&
                    title.toLowerCase() == 'nama'
                ? Colors.red
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
