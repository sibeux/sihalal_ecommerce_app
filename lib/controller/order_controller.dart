import 'package:get/get.dart';

class OrderController extends GetxController {
  var selectedOrderStatus = 'Semua'.obs;

  void changeOrderStatus(String status) {
    selectedOrderStatus.value = status;
  }

  
}
