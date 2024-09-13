import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var imageIndex = 1.obs;
  var isShowAllDescription = false.obs;
  var useMaxLine = 5.obs;
  var useOverflow = RxList<TextOverflow>([TextOverflow.ellipsis]).obs;

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

  get maxLine => useMaxLine.value;
  get overflow => useOverflow.value;
}