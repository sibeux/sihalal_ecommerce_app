import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/cart_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/favorite_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_detail_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_info_product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/checkout_screen/checkout_screen.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/persistent_bar_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/cart_widgets/button_quantity.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
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
              Obx(
                () => cartController.listCart.isEmpty
                    ? const SizedBox()
                    : ListView(
                        shrinkWrap: true,
                        children: cartController.listCart.map((cart) {
                          cartController.quantity
                              .putIfAbsent(cart.idCart, () => 1);
                          cartController.productStock.putIfAbsent(
                              cart.idProduk, () => cart.stokProduk);
                          return InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (cart.stokProduk == 0) {
                                return;
                              }
                              cartController.isLoadingRedirectToCheckoutScreen
                                  .value = true;
                              final ShopInfoProductController
                                  shopInfoProductController =
                                  Get.put(ShopInfoProductController());
                              Get.put(FavoriteController());

                              final ProductDetailController
                                  productDetailController = Get.put(
                                ProductDetailController(
                                  idProduk: cart.idProduk,
                                  fotoImage1: cart.fotoProduk,
                                ),
                              );

                              await productDetailController
                                  .fetchDataProductDetail(
                                      idProduk: cart.idProduk);

                              await Future.doWhile(() async {
                                if (productDetailController.productDetailData
                                        .any((item) =>
                                            item.uidProduct == cart.idProduk) &&
                                    shopInfoProductController
                                        .shopInfo.isNotEmpty) {
                                  return false;
                                }
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                return true;
                              });

                              Get.to(
                                () => CheckoutScreen(
                                  product: productDetailController
                                      .productDetailData
                                      .firstWhere((element) =>
                                          element.uidProduct == cart.idProduk),
                                  shopName: shopInfoProductController
                                      .shopInfo[0]!.namaToko,
                                  stockProduct: cart.stokProduk,
                                ),
                                arguments: {
                                  'qty': cartController.quantity[cart.idCart],
                                  'idCart': cart.idCart,
                                }
                              );
                              cartController.isLoadingRedirectToCheckoutScreen
                                  .value = false;
                            },
                            child: Dismissible(
                              key: Key(cart.idCart),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                cartController.changeCart(
                                  method: 'delete',
                                  idProduk: cart.idProduk,
                                  idCart: cart.idCart,
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Icon(Icons.delete,
                                    color: Colors.white),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: cart.fotoProduk,
                                            ),
                                          ),
                                        ),
                                        const WidthBox(20),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Sisa ${cart.stokProduk}',
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: HexColor('#d88e4d'),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const HeightBox(3),
                                              Text(
                                                cart.namaProduk,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const HeightBox(5),
                                              Text(
                                                priceFormatter(cart.hargaProduk
                                                    .toString()),
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(1),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const HeightBox(5),
                                              ButtonQuantity(
                                                idCart: cart.idCart,
                                                idProduct: cart.idProduk,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  cart.stokProduk == 0
                                      ? Container(
                                          height: 120,
                                          width: double.infinity,
                                          color: Colors.black.withOpacity(0.5),
                                          child: const Center(
                                            child: Text(
                                              'Stok Habis',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
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
        Obx(
          () => cartController.isLoadingRedirectToCheckoutScreen.value
              ? const Opacity(
                  opacity: 0.5,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                )
              : const SizedBox(),
        ),
        Obx(
          () => cartController.isLoadingRedirectToCheckoutScreen.value
              ? Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
