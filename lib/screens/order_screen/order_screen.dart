import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/order_list_container.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/order_status_button.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OrderStatusButton(
                  title: 'Diproses',
                ),
                OrderStatusButton(
                  title: 'Dikirim',
                ),
                OrderStatusButton(
                  title: 'Selesai',
                ),
                OrderStatusButton(
                  title: 'Dibatalkan',
                ),
              ],
            ),
            const HeightBox(10),
            Obx(
              () => Expanded(
                child: orderController.isLoadingGetOrder.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: orderController.orderList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return index == orderController.orderList.length
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: const Center(
                                    child: Text("Tidak ada data lainnya"),
                                  ),
                                )
                              : OrderListContainer(
                                  order: orderController.orderList[index],
                                );
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
