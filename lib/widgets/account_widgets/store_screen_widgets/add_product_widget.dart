import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class InsertImageProduct extends StatelessWidget {
  const InsertImageProduct({
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
              Obx(
                () => Text(
                  '${addNewProductController.nameProduct.value.length}/225',
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
                  controller: addNewProductController.nameProductTextController,
                  onChanged: (value) {
                    addNewProductController.nameProduct.value = value;
                  },
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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

class InsertDescriptionProduct extends StatelessWidget {
  const InsertDescriptionProduct({
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
                'Deskripsi Produk',
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
                  '${addNewProductController.descriptionProduct.value.length}/3000',
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
                      addNewProductController.descriptionProductTextController,
                  onChanged: (value) {
                    addNewProductController.descriptionProduct.value = value;
                  },
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                () => addNewProductController.descriptionProduct.value.isEmpty
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          addNewProductController
                              .descriptionProductTextController
                              .clear();
                          addNewProductController.descriptionProduct.value = '';
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
    final addNewProductController = Get.find<AddNewProductController>();
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
          GestureDetector(
            onTap: () {},
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
                  Text(
                    addNewProductController.categoryProduct.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
          GestureDetector(
            onTap: () {},
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
                  Text(
                    addNewProductController.merkProduct.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
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
          GestureDetector(
            onTap: () {},
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
                  Text(
                    addNewProductController.noHalalProduct.value,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
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
    final addNewProductController = Get.find<AddNewProductController>();
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
                        addNewProductController.priceProductTextController,
                    onChanged: (value) {
                      addNewProductController.formatPrice(value);
                    },
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                        addNewProductController.stockProductTextController,
                    onChanged: (value) {
                      addNewProductController.formatStock(value);
                    },
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
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

class InsertDeliveryPriceProduct extends StatelessWidget {
  const InsertDeliveryPriceProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final addNewProductController = Get.find<AddNewProductController>();
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
        child: const Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              color: Colors.black,
              size: 20,
            ),
            WidthBox(8),
            Text(
              'Ongkos Kirim',
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
              'Rp. 16.000',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidthBox(5),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
