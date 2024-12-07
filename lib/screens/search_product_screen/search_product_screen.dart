import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/search_product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/search_product_screen/vertical_search_product.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchProductController searchProductController =
        Get.find<SearchProductController>();
    return Scaffold(
      backgroundColor: ColorPalette().white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColorPalette().white,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorPalette().primary,
          ),
        ),
        title: TextFormField(
          controller: searchProductController.controller,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            searchProductController.onChanged(value);
          },
          style: TextStyle(color: HexColor('#575757'), fontSize: 12),
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: HexColor('#fefffe'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            hintText: 'Cari produk halal di SiHALAL',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            // * agar textfield tidak terlalu lebar, maka dibuat constraints
            suffixIconConstraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 20,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 20,
            ),
            suffixIcon: Obx(() => searchProductController.isTypingValue
                ? GestureDetector(
                    onTap: () {
                      searchProductController.controller.clear();
                      searchProductController.onChanged('');
                    },
                    child: Icon(
                      Icons.close,
                      color: HexColor('#575757'),
                    ),
                  )
                : const SizedBox.shrink()),
            enabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (searchProductController.textValue.trim().isEmpty) {
                return;
              }
              searchProductController.isNowSearch = true;
              searchProductController.searchProduct(
                offset: 0,
              );
              Get.offUntil(
                MaterialPageRoute(
                  builder: (_) => VerticalSearchProduct(
                    keyword: searchProductController.textValue.value,
                  ),
                  fullscreenDialog: true,
                ),
                (route) => route.isFirst,
              );
            },
            child: Obx(
              () => Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: searchProductController.textValue.trim().isEmpty
                      ? Colors.grey
                      : ColorPalette().primary,
                  border: Border.all(color: ColorPalette().primary, width: 2),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: ColorPalette().primary, width: 2),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(7),
      bottomLeft: Radius.circular(7),
    ),
  );
}
