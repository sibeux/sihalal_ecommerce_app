

import 'package:get/get.dart';
enum Expedition  {jne, jnt, tiki, pos}
class CheckoutController extends GetxController {
  var quantity = 1.obs;
  var expedition = Expedition.jne.obs;
  
  @override
  void onInit() {
    super.onInit();
    quantity.value = 1;
    expedition.value = Expedition.jne;
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

  get getExpedition => Expedition.values;
}