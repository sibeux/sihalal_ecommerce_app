import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';

class FormReviewMessage extends StatelessWidget {
  const FormReviewMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productReviewController = Get.find<ProductReviewController>();
    return TextFormField(
      controller: productReviewController.reviewTextController,
      cursorColor: HexColor('#575757'),
      textAlignVertical: TextAlignVertical.center,
      enableSuggestions: true,
      keyboardType: TextInputType.text,
      maxLength: 1000,
      maxLines: 7,
      onChanged: (value) {
        productReviewController.onChanged(value);
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      buildCounter: (context,
          {int? currentLength, int? maxLength, bool? isFocused}) {
        return null; // Menghilangkan teks maxLength
      },
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: HexColor('#fefffe'),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        hintText: 'Bagaimana kesan Anda dengan produk ini?',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 45,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 45,
        ),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: HexColor('#575757').withOpacity(0.5),
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(7),
    ),
  );
}
