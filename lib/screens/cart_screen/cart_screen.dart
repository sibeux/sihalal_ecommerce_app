import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/cart_controller.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/persistent_bar_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Stack(
      children: [
        Scaffold(
          backgroundColor: HexColor('#fefffe'),
          appBar: AppBar(
            backgroundColor: HexColor('#fefffe'),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            title: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Keranjang'),
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: Column(
            children: [
              const Divider(
                height: 0.4,
                thickness: 0.4,
              ),
              const HeightBox(20),
              Obx(
                () => cartController.listCart.isNotEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1,
                                    child: Image.asset(
                                        'assets/images/icon-general/cart.png'),
                                  ),
                                ),
                                const WidthBox(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Keranjang belanja anda masih kosong',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const HeightBox(10),
                                      Text(
                                        'Yuk, belanja sekarang!',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const HeightBox(10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.offAll(
                                  () => const PersistenBarScreen(),
                                  transition: Transition.native,
                                  fullscreenDialog: true,
                                  popGesture: false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: ColorPalette().primary,
                                elevation: 0, // Menghilangkan shadow
                                splashFactory: InkRipple.splashFactory,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: const Size(
                                  double.infinity,
                                  35,
                                ),
                              ),
                              child: const Text(
                                'Beli Sekarang',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Obx(() => cartController.listCart.isEmpty
                  ? const SizedBox()
                  : ListView(
                      shrinkWrap: true,
                      children: cartController.listCart.map((cart) {
                        return ListTile(
                          title: Text(cart.namaProduk),
                          subtitle: Text(cart.hargaProduk.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartController.changeCart(
                                method: 'delete',
                                idProduk: cart.idProduk,
                              );
                            },
                          ),
                        );
                      }).toList(),
                    )),
            ],
          ),
        ),
        Obx(
          () => cartController.isLoadingReadCart.value
              ? const Opacity(
                  opacity: 1,
                  child: ModalBarrier(dismissible: false, color: Colors.white),
                )
              : const SizedBox(),
        ),
        Obx(
          () => cartController.isLoadingReadCart.value
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
