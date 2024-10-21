import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class InsertImage extends StatelessWidget {
  const InsertImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addNewProductController = Get.put(AddNewProductController());
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
                  fontWeight: FontWeight.w400,
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
                  urlImage: addNewProductController.urlImage1.value,
                ),
                const WidthBox(10),
                if (addNewProductController.countImage.value >= 1)
                  ImagePlaceholder(
                    urlImage: addNewProductController.urlImage2.value,
                  ),
                const WidthBox(10),
                if (addNewProductController.countImage.value >= 2)
                  ImagePlaceholder(
                    urlImage: addNewProductController.urlImage3.value,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
    required this.urlImage,
  });

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    final addNewProductController = Get.find<AddNewProductController>();
    return Obx(
      () =>
          addNewProductController.isInsertImageLoading.value && urlImage.isEmpty
              ? DottedBorder(
                  color: Colors.red,
                  strokeWidth: 1,
                  dashPattern: const [3, 3],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(5),
                  child: const SizedBox(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  ),
                )
              : urlImage.isNotEmpty
                  ? Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black.withOpacity(0.3),
                          width: 0.3,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: urlImage,
                        height: 75,
                        width: 75,
                        filterQuality: FilterQuality.medium,
                        fit: BoxFit.cover,
                        maxHeightDiskCache: 200,
                        maxWidthDiskCache: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await addNewProductController.insertImage();
                      },
                      child: DottedBorder(
                        color: Colors.red,
                        strokeWidth: 1,
                        dashPattern: const [3, 3],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(5),
                        child: const SizedBox(
                          width: 70,
                          height: 70,
                          child: Center(
                            child: Text(
                              '+ Tambah Foto',
                              style: TextStyle(
                                color: Colors.red, // Warna teks
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
    final addNewProductController = Get.find<AddNewProductController>();
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
              Obx(() => Text(
                    '${addNewProductController.nameProduct.value.length}/225',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ],
          ),
          const HeightBox(15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: addNewProductController.nameProductTextController,
                  onChanged: (value) {
                    addNewProductController.nameProduct.value = value;
                  },
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
                () => addNewProductController.nameProduct.value.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          addNewProductController.nameProductTextController
                              .clear();
                          addNewProductController.nameProduct.value = '';
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
