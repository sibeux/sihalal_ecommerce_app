import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/change_name_shop_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/alert_modal_dialog/discard_change_name_shop_dialog.dart';

final changeNameShopController = Get.put(ChangeNameShopController());
final FocusNode _focusNode = FocusNode();
final textController = changeNameShopController.controller;

class ChangeNameShopScreen extends StatelessWidget {
  const ChangeNameShopScreen(
      {super.key, required this.shopName, required this.foto});

  final String shopName, foto;

  @override
  Widget build(BuildContext context) {
    textController.text = shopName;
    var tapIndex = 0;
    changeNameShopController.textValue.value = textController.text;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorPalette().white,
          appBar: AppBar(
            backgroundColor: ColorPalette().white,
            toolbarHeight: 80,
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (changeNameShopController.textValue.value.toLowerCase() !=
                    shopName.toLowerCase()) {
                  discardChangeNameShopDialog(context);
                } else {
                  Get.back();
                }
              },
            ),
            title: const Text('Ubah Toko'),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            actions: [
              Obx(
                () => changeNameShopController.isTypingValue &&
                        changeNameShopController.textValue.value
                                .toLowerCase() !=
                            shopName.toLowerCase()
                    ? saveButton(
                        color: ColorPalette().primary,
                        onTap: () async {
                          await changeNameShopController.changeNameShop();
                          Get.back();
                        },
                      )
                    : saveButton(
                        color: Colors.black.withOpacity(0.4),
                        onTap: () {},
                      ),
              )
            ],
          ),
          body: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: foto,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                    maxHeightDiskCache: 500,
                    maxWidthDiskCache: 500,
                    filterQuality: FilterQuality.low,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/shimmer/profile/profile_shimmer.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/shimmer/profile/profile_shimmer.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Theme(
                    data: ThemeData(
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.blue, // Cursor color
                        selectionColor: Colors.yellow.withOpacity(0.4),
                        selectionHandleColor: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    child: TextField(
                      onTap: () {
                        if (tapIndex == 0) {
                          textController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: textController.text.length,
                          );
                          tapIndex++;
                        } else {}
                      },
                      onChanged: (value) {
                        changeNameShopController.onTyping(value);
                        changeNameShopController.textValue.value = value;
                      },
                      onTapOutside: (event) {
                        _focusNode.unfocus();
                      },
                      controller: textController,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 0),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black
                                  .withOpacity(0.7)), // Color when focused
                        ),
                        hintText: 'Nama Toko',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => changeNameShopController.isLoadingChangeNameShop.value
              ? const Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                )
              : const SizedBox(),
        ),
        Obx(
          () => changeNameShopController.isLoadingChangeNameShop.value
              ? Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  GestureDetector saveButton({
    required Color color,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // default margin dari IconButton ke kanan adalah 24
        // makanya leading gak perlu dikasih margin
        margin: const EdgeInsets.only(right: 24),
        child: Text(
          'Simpan',
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
