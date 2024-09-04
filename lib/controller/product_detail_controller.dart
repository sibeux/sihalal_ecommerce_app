import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  var imageIndex = 1.obs;

  void changeImageIndex(int index) {
    imageIndex.value = index;
  }
}