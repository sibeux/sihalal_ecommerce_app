import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/order_list_container.dart';
import 'package:sihalal_ecommerce_app/widgets/order_widgets/button/order_status_filter_button.dart';
import 'package:velocity_x/velocity_x.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();
    final bool isFromAnotherScreen = Get.arguments == null
        ? false
        : Get.arguments['isFromAccountScreen'] == true
            ? true
            : false;
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: ColorPalette().primary,
            child: Scaffold(
              backgroundColor: HexColor('#fefffe'),
              appBar: AppBar(
                backgroundColor: HexColor('#fefffe'),
                surfaceTintColor: Colors.transparent,
                titleSpacing: !isFromAnotherScreen ? 20 : 0,
                leading: !isFromAnotherScreen
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                title: Text(
                  !isFromAnotherScreen ? 'Pesanan' : 'Riwayat Pesanan',
                ),
                titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: OverflowBox(
                        maxWidth: MediaQuery.of(context).size.width,
                        child: const Divider(
                          height: 0.4,
                          thickness: 0.4,
                        ),
                      ),
                    ),
                    const HeightBox(10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OrderStatusFilterButton(
                          title: 'Diproses',
                        ),
                        OrderStatusFilterButton(
                          title: 'Dikirim',
                        ),
                        OrderStatusFilterButton(
                          title: 'Selesai',
                        ),
                        OrderStatusFilterButton(
                          title: 'Dibatalkan',
                        ),
                      ],
                    ),
                    const HeightBox(10),
                    Obx(
                      () => Expanded(
                        child: orderController.isLoadingGetOrder.value
                            ? const SizedBox()
                            : ListView.builder(
                                itemCount: orderController.orderList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return index ==
                                          orderController.orderList.length
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: const Center(
                                            child:
                                                Text("Tidak ada data lainnya"),
                                          ),
                                        )
                                      : OrderListContainer(
                                          order:
                                              orderController.orderList[index],
                                          isBuyer: true,
                                        );
                                }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Obx(
          () => orderController.isLoadingGetOrder.value
              ? const Opacity(
                  opacity: 1,
                  child: ModalBarrier(dismissible: false, color: Colors.white),
                )
              : const SizedBox(),
        ),
        Obx(
          () => orderController.isLoadingGetOrder.value
              ? Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: ColorPalette().primary,
                    size: 50,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
