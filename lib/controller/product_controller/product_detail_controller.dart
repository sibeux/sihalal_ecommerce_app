import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_review_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_info_product_controller.dart';

class ProductDetailController extends GetxController {
  var imageIndex = 1.obs;
  var isShowAllDescription = false.obs;
  var useMaxLine = 5.obs;
  var useOverflow = RxList<TextOverflow>([TextOverflow.ellipsis]).obs;

  final shopInfoProductController = Get.find<ShopInfoProductController>();
  final productReviewController = Get.put(ProductReviewController());

  @override
  void onClose() {
    shopInfoProductController.needMoveScreen.value = false;
    super.onClose();
  }

  void changeImageIndex(int index) {
    imageIndex.value = index;
  }

  void showAllDescription() {
    isShowAllDescription.value = true;
    useMaxLine.value = 100;
    useOverflow.value = RxList<TextOverflow>([TextOverflow.visible]);
  }

  void showLessDescription() {
    isShowAllDescription.value = false;
    useMaxLine.value = 5;
    useOverflow.value = RxList<TextOverflow>([TextOverflow.ellipsis]);
  }

  void getProductDetailData(String idProduk) {
    showLessDescription();
    shopInfoProductController.getShopInfo(idProduk);
    productReviewController.getProductReview(idProduk);
  }

  get maxLine => useMaxLine.value;
  get overflow => useOverflow.value;
}
