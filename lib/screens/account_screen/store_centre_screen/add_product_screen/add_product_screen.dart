import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/store_screen_widgets/add_product_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sellerProductController = Get.put(SellerProductController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#f4f4f5'),
          resizeToAvoidBottomInset: true,
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
            title: const Text('Tambah Produk'),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: Stack(
            children: [
              const SingleChildScrollView(
                child: Column(
                  children: [
                    HeightBox(10),
                    InsertImageProduct(),
                    HeightBox(10),
                    InsertNameProduct(),
                    HeightBox(10),
                    InsertDescriptionProduct(),
                    HeightBox(10),
                    InsertCategorySHProduct(),
                    HeightBox(10),
                    InsertStockPriceProduct(),
                    HeightBox(10),
                    InsertDeliveryPriceProduct(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Divider(
                  color: Colors.grey.withOpacity(0.3),
                  thickness: 2,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ButtonSaveNewProduct(),
        ),
        Obx(
          () => sellerProductController.isSendSellerProductLoading.value
              ? const Opacity(
                  opacity: 0.8,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                )
              : const SizedBox(),
        ),
        Obx(
          () => sellerProductController.isSendSellerProductLoading.value
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
