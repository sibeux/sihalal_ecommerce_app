import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/seller_product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/add_product_screen/add_category_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/add_product_screen/add_merksh_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class InsertImageProduct extends StatelessWidget {
  const InsertImageProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Foto Produk',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'Foto 1:1',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const HeightBox(15),
          Obx(
            () => Row(
              children: [
                ImagePlaceholder(
                  urlImage: sellerProductController.urlImage1.value,
                  index: 1,
                ),
                const WidthBox(10),
                if (sellerProductController.countImage.value >= 1)
                  ImagePlaceholder(
                    urlImage: sellerProductController.urlImage2.value,
                    index: 2,
                  ),
                const WidthBox(10),
                if (sellerProductController.countImage.value >= 2)
                  ImagePlaceholder(
                    urlImage: sellerProductController.urlImage3.value,
                    index: 3,
                  ),
              ],
            ),
          ),
          Obx(
            () => !sellerProductController.isImageFileTooLarge.value
                ? const SizedBox()
                : Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: HexColor('#fff9f8'),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
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
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
    required this.urlImage,
    required this.index,
  });

  final String urlImage;
  final int index;

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Obx(
      () => sellerProductController.isInsertImageLoading.value &&
              urlImage.isEmpty
          ? DottedBorder(
              color: ColorPalette().primary,
              strokeWidth: 1,
              dashPattern: const [3, 3],
              borderType: BorderType.RRect,
              radius: const Radius.circular(5),
              child: SizedBox(
                width: 70,
                height: 70,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorPalette().primary),
                  ),
                ),
              ),
            )
          : urlImage.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black.withOpacity(0.3),
                          width: 0.3,
                        ),
                      ),
                      child: urlImage.contains('http')
                          ? CachedNetworkImage(
                              imageUrl: urlImage,
                              height: 75,
                              width: 75,
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover,
                              maxHeightDiskCache: 200,
                              maxWidthDiskCache: 200,
                            )
                          : Image.file(
                              File(urlImage),
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                    ),
                    if (sellerProductController.countImage.value == index)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            sellerProductController.deleteImage(index);
                            sellerProductController.isImageFileTooLarge.value =
                                false;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              : GestureDetector(
                  onTap: () async {
                    await sellerProductController.insertImage();
                  },
                  child: DottedBorder(
                    color: ColorPalette().primary,
                    strokeWidth: 1,
                    dashPattern: const [3, 3],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(5),
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Center(
                        child: Text(
                          '+ Tambah Foto',
                          style: TextStyle(
                            color: ColorPalette().primary, // Warna teks
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}

class InsertNameProduct extends StatelessWidget {
  const InsertNameProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Nama Produk',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  '${sellerProductController.nameProduct.value.length}/225',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: sellerProductController.nameProductTextController,
                  onChanged: (value) {
                    sellerProductController.nameProduct.value = value;
                  },
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  maxLength: 225,
                  buildCounter: (context,
                      {int? currentLength, int? maxLength, bool? isFocused}) {
                    return null; // Menghilangkan teks maxLength
                  },
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Masukkan Nama Produk',
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
                () => sellerProductController.nameProduct.value.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          sellerProductController.nameProductTextController
                              .clear();
                          sellerProductController.nameProduct.value = '';
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
        ],
      ),
    );
  }
}

class InsertDescriptionProduct extends StatelessWidget {
  const InsertDescriptionProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Deskripsi Produk',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Obx(
                () => Text(
                  '${sellerProductController.descriptionProduct.value.length}/3000',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const HeightBox(15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller:
                      sellerProductController.descriptionProductTextController,
                  onChanged: (value) {
                    sellerProductController.descriptionProduct.value = value;
                  },
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: null, // auto menambah baris
                  maxLength: 3000,
                  buildCounter: (context,
                      {int? currentLength, int? maxLength, bool? isFocused}) {
                    return null; // Menghilangkan teks maxLength
                  },
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Masukkan Deskripsi Produk',
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
                () => sellerProductController.descriptionProduct.value.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          sellerProductController
                              .descriptionProductTextController
                              .clear();
                          sellerProductController.descriptionProduct.value = '';
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
        ],
      ),
    );
  }
}

class InsertCategorySHProduct extends StatelessWidget {
  const InsertCategorySHProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(
                () => const AddCategoryScreen(),
                transition: Transition.rightToLeftWithFade,
                fullscreenDialog: true,
                popGesture: false,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.list_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  const WidthBox(8),
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Text(
                      sellerProductController.categoryProduct.value.isEmpty
                          ? ''
                          : sellerProductController
                              .categoryProduct.value.capitalized,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const WidthBox(5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const HeightBox(10),
          const Divider(
            thickness: 0.3,
            height: 0.3,
          ),
          const HeightBox(10),
          InkWell(
            onTap: () {
              if (sellerProductController.categoryProduct.value.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Harap pilih kategori terlebih dahulu',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  textColor: Colors.white,
                  fontSize: 10.0,
                );
              } else {
                Get.to(
                  () => const AddMerkshScreen(),
                  transition: Transition.rightToLeft,
                  fullscreenDialog: true,
                  popGesture: false,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.diamond_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  const WidthBox(8),
                  const Text(
                    'Merek',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Text(
                      sellerProductController.merkProduct.value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const WidthBox(5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const HeightBox(10),
          const Divider(
            thickness: 0.3,
            height: 0.3,
          ),
          const HeightBox(10),
          InkWell(
            onTap: () {
              if (sellerProductController.categoryProduct.value.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Harap pilih kategori terlebih dahulu',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  textColor: Colors.white,
                  fontSize: 10.0,
                );
              } else {
                Get.to(
                  () => const AddMerkshScreen(),
                  transition: Transition.rightToLeft,
                  fullscreenDialog: true,
                  popGesture: false,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.document_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  const WidthBox(8),
                  const Text(
                    'Nomor Halal',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Text(
                      sellerProductController.noHalalProduct.value,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const WidthBox(5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InsertStockPriceProduct extends StatelessWidget {
  const InsertStockPriceProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(
                  Ionicons.pricetags_outline,
                  color: Colors.black,
                  size: 20,
                ),
                const WidthBox(8),
                const Text(
                  'Harga',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller:
                        sellerProductController.priceProductTextController,
                    onChanged: (value) {
                      sellerProductController.formatPrice(value);
                    },
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    maxLength: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    buildCounter: (context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Atur',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const HeightBox(10),
          const Divider(
            thickness: 0.3,
            height: 0.3,
          ),
          const HeightBox(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(
                  Ionicons.layers_outline,
                  color: Colors.black,
                  size: 20,
                ),
                const WidthBox(8),
                const Text(
                  'Stok',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.end,
                    controller:
                        sellerProductController.stockProductTextController,
                    onChanged: (value) {
                      sellerProductController.formatStock(value);
                    },
                    onTap: () {
                      if (sellerProductController.stockProduct.value == "0") {
                        sellerProductController.stockProductTextController
                            .selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: sellerProductController
                                  .stockProductTextController.text.length),
                        );
                      }
                    },
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    maxLength: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    buildCounter: (context,
                        {int? currentLength, int? maxLength, bool? isFocused}) {
                      return null;
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InsertWeightProduct extends StatelessWidget {
  const InsertWeightProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            const Icon(
              Ionicons.cube_outline,
              color: Colors.black,
              size: 20,
            ),
            const WidthBox(8),
            const Text(
              'Berat',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.end,
                controller: sellerProductController.weightProductTextController,
                onChanged: (value) {
                  sellerProductController.formatWeight(value);
                },
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                keyboardType: TextInputType.number,
                maxLines: 1,
                maxLength: 16,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                buildCounter: (context,
                    {int? currentLength, int? maxLength, bool? isFocused}) {
                  return null;
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Atur Berat',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Obx(
              () => sellerProductController.weightProduct.value.isNotEmpty
                  ? const Text(
                      ' g',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonSaveProduct extends StatelessWidget {
  const ButtonSaveProduct(
      {super.key, required this.title, required this.isNew});

  final String title;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: HexColor('#fefeff'),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Obx(
        () => sellerProductController.isAllDataValid()
            ? AddressButtonWidget(
                onPressed: () async {
                  await sellerProductController.sendDataSellerProduct(
                    isNew: isNew,
                  );
                },
                title: title,
                icon: Icons.save,
                foregroundColor: Colors.white,
                backgroundColor: ColorPalette().primary,
              )
            : AbsorbPointer(
                child: AddressButtonWidget(
                  onPressed: () {},
                  title: title,
                  icon: Icons.save,
                  foregroundColor: HexColor('#a8b5c8'),
                  backgroundColor: HexColor('#e5eaf5'),
                ),
              ),
      ),
    );
  }
}
