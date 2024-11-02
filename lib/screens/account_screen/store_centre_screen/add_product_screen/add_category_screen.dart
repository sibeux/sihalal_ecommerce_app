import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';

enum CategoryType {
  gula,
  bumbu,
  tepung,
  santan,
  susu,
  pemanis,
  daging,
  garam,
  minyak,
  saus,
  pasta,
  keju,
  olahan,
  lainnya,
}

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.find<SellerProductController>();
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Tambah Kategori'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          Container(
            width: double.infinity,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            color: HexColor('#f4f4f5'),
            child: const Text(
              'Semua Kategori',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (CategoryType category in CategoryType.values)
                    InkWell(
                      onTap: () {
                        if (sellerProductController
                                .merkProduct.value.isNotEmpty &&
                            sellerProductController.categoryProduct.value !=
                                category.toString().split('.').last) {
                          sellerProductController.merkProduct.value = '';
                          sellerProductController.noHalalProduct.value = '';
                        }
                        sellerProductController.categoryProduct.value =
                            category.toString().split('.').last;
                        Get.back();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              // perlu di-split karena hasilnya: 'CategoryType.gula'
                              category.toString().split('.').last.capitalize!,
                              style: TextStyle(
                                color: sellerProductController
                                            .categoryProduct.value ==
                                        category.toString().split('.').last
                                    ? ColorPalette().primary
                                    : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const Divider(
                            height: 0.3,
                            thickness: 0.3,
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
