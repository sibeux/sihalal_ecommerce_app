import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_seller_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_info_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/shop_dashboard_screen/shop_dashboard_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/add_product_screen/add_product_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/list_product_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/store_order_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/sale_product_status.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/store_info.dart';
import 'package:velocity_x/velocity_x.dart';

class StoreCentreScreen extends StatelessWidget {
  const StoreCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    final userAddressController = Get.put(UserAddressController());
    final shopInfoProductController = Get.put(ShopInfoProductController());
    final getSellerProductController = Get.put(GetSellerProductController());
    getSellerProductController.getProducts(
      email: userProfileController.userData[0].emailuser,
      idUser: userProfileController.userData[0].idUser,
    );
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Toko Saya'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => InkWell(
                splashFactory: InkRipple.splashFactory,
                onTap: () async {
                  if (shopInfoProductController.isLoading.value ||
                      getSellerProductController.visibleProductList.isEmpty ||
                      getSellerProductController.isGetProductLoading.value) {
                    if (getSellerProductController.visibleProductList.isEmpty &&
                        !getSellerProductController.isGetProductLoading.value) {
                      Fluttertoast.showToast(
                        msg: 'Tambahkan Produk Terlebih Dahulu',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Tunggu Sebentar',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 10.0,
                      );
                    }
                  } else {
                    await Get.to(
                      () => ShopDashboardScreen(
                        idUserToko: userProfileController.userData[0].idUser,
                        namaToko: userProfileController.userData[0].nameShop ==
                                ''
                            ? 'Toko ${userProfileController.userData[0].nameUser}'
                            : userProfileController.userData[0].nameShop,
                        fotoToko: userProfileController.userData[0].fotoUser,
                        lokasiToko: userAddressController.addressList
                                .firstWhere(
                                    (element) => element!.isStore == true)
                                ?.city ??
                            '',
                        ratingToko: shopInfoProductController
                                    .shopInfo[0]!.totalRating ==
                                '0.0000'
                            ? '0.0'
                            : ('${double.parse(shopInfoProductController.shopInfo[0]!.totalRating)}'),
                        jumlahRating:
                            shopInfoProductController.shopInfo[0]!.jumlahRating,
                      ),
                      transition: Transition.downToUp,
                      fullscreenDialog: true,
                      popGesture: false,
                    );
                  }
                },
                child: Text(
                  'Lihat Toko',
                  style: TextStyle(
                    color: shopInfoProductController.isLoading.value ||
                            getSellerProductController
                                .visibleProductList.isEmpty ||
                            getSellerProductController.isGetProductLoading.value
                        ? Colors.grey
                        : ColorPalette().primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 0.5,
            thickness: 0.5,
          ),
          const HeightBox(20),
          const StoreInfo(),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: HexColor('#eff4f8'),
            height: 8,
            thickness: 8,
          ),
          const HeightBox(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'Penjualan',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const StoreOrderScreen(),
                      transition: Transition.downToUp,
                      popGesture: false,
                      fullscreenDialog: true,
                    );
                  },
                  child: Text(
                    'Lihat Riwayat',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ColorPalette().primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
          const HeightBox(20),
          const SaleProductStatus(),
          const SizedBox(
            height: 20,
          ),
          Divider(
            color: HexColor('#eff4f8'),
            height: 8,
            thickness: 8,
          ),
          const HeightBox(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    'Produk',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(
                      () => const AddProductScreen(),
                      transition: Transition.rightToLeft,
                      fullscreenDialog: true,
                      popGesture: false,
                    );
                  },
                  child: Text(
                    'Tambah Produk',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ColorPalette().primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const HeightBox(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                if (!getSellerProductController.isGetProductLoading.value) {
                  Get.to(
                    () => const ListProductScreen(),
                    transition: Transition.rightToLeft,
                    fullscreenDialog: true,
                    popGesture: false,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Tunggu Sebentar',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black.withOpacity(0.5),
                    textColor: Colors.white,
                    fontSize: 10.0,
                  );
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produk Saya',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const HeightBox(5),
                      Obx(
                        () =>
                            getSellerProductController.isGetProductLoading.value
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        '0 Produk',
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    getSellerProductController
                                            .sellerProductList.isEmpty
                                        ? '0 Produk'
                                        : '${getSellerProductController.sellerProductList.length} Produk',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black.withOpacity(0.7),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          const HeightBox(15),
          Divider(
            color: HexColor('#eff4f8'),
            height: 8,
            thickness: 8,
          ),
        ],
      ),
    );
  }
}
