import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';

class AddMerkshScreen extends StatelessWidget {
  const AddMerkshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addNewProductController = Get.find<AddNewProductController>();
    addNewProductController.getMerkshProduct();
    return Stack(
      children: [
        Scaffold(
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
            title: const Text('Merek & Sertifikat Halal'),
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
                child: Text(
                  addNewProductController.categoryProduct.value == 'lainnya'
                      ? 'Semua Merek'
                      : 'Merek ${addNewProductController.categoryProduct.value.capitalize}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Obx(
                () => addNewProductController.isGetMerkshLoading.value
                    ? const Text(
                        'Mengambil Data...',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i <
                                        addNewProductController
                                            .listMerkshProduct.length;
                                    i++)
                                  InkWell(
                                    onTap: () {
                                      addNewProductController
                                              .merkProduct.value =
                                          addNewProductController
                                              .listMerkshProduct[i].nameMerkSh;
                                      addNewProductController
                                              .noHalalProduct.value =
                                          addNewProductController
                                              .listMerkshProduct[i].numberSh;
                                      Get.back();
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 15),
                                          child: Row(
                                            children: [
                                              Text(
                                                addNewProductController
                                                    .listMerkshProduct[i]
                                                    .nameMerkSh,
                                                style: TextStyle(
                                                  color: addNewProductController
                                                              .merkProduct
                                                              .value ==
                                                          addNewProductController
                                                              .listMerkshProduct[
                                                                  i]
                                                              .nameMerkSh
                                                      ? ColorPalette().primary
                                                      : Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                addNewProductController
                                                    .listMerkshProduct[i]
                                                    .numberSh,
                                                style: TextStyle(
                                                  color: HexColor('#640175'),
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          height: 0.3,
                                          thickness: 0.3,
                                        ),
                                      ],
                                    ),
                                  ),
                                if (addNewProductController
                                    .listMerkshProduct.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      'Data tidak ditemukan',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
              )
            ],
          ),
        ),
        Obx(
          () => addNewProductController.isGetMerkshLoading.value
              ? const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                )
              : const SizedBox(),
        ),
        Obx(
          () => addNewProductController.isGetMerkshLoading.value
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.white,
                    size: 50,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
