import 'package:get/get.dart';

class CheckoutController extends GetxController {
  var quantity = 1.obs;
  
  @override
  void onInit() {
    super.onInit();
    quantity.value = 1;
  }

  void increment() {
    if (quantity.value < 99) {
      quantity.value++;
    }
  }

  void decrement() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}