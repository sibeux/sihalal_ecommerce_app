import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/product_detail_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_info_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/checkout_screen/checkout_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/button.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/merk_stok_weight_product.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/product_review.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/shimmer_product_detail.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/shop_info.dart';
import 'package:sihalal_ecommerce_app/widgets/product_detail_widgets/shop_info_shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

final _pageController = PageController(initialPage: 0, viewportFraction: 1);

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.idProduk,
    required this.idUser,
    required this.fotoImage1,
  });

  final String idProduk, idUser, fotoImage1;

  @override
  Widget build(BuildContext context) {
    final shopInfoProductController = Get.put(ShopInfoProductController());
    final productDetailController = Get.put(ProductDetailController(
      idProduk: idProduk,
      fotoImage1: fotoImage1,
    ));
    final userProfileController = Get.find<UserProfileController>();

    final box = GetStorage();
    final login = box.read('login') == true;

    return Scaffold(
      backgroundColor: HexColor('#fefeff'),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: HexColor('#fefeff'),
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {
              // Do something
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
              onPressed: () {
                // Do something
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (userProfileController.idUser == idUser)
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.yellow.withOpacity(0.4),
              alignment: Alignment.center,
              child: const Text(
                'Anda sedang melihat produk dari toko anda',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          Expanded(
            child: ScrollConfiguration(
              behavior: NoGlowScrollBehavior(),
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: ColorPalette().primary,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Divider(
                        height: 0.5,
                        thickness: 0.5,
                      ),
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Obx(
                                () => ScrollConfiguration(
                                  behavior: NoGlowScrollBehavior(),
                                  child: PageView.builder(
                                    itemCount: productDetailController
                                        .imageProductCount.value,
                                    controller: _pageController,
                                    onPageChanged: (value) {
                                      productDetailController
                                          .changeImageIndex(value + 1);
                                    },
                                    itemBuilder: (context, index) {
                                      return CachedNetworkImage(
                                        imageUrl: productDetailController
                                            .listImageProduct[index],
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => productDetailController
                                    .isLoadingFetchDataProduct.value
                                ? const SizedBox()
                                : Positioned(
                                    bottom: 10,
                                    left: 20,
                                    child: Container(
                                      width: 35,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: HexColor('#fefeff'),
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 217, 220, 231),
                                          width: 1.1,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                        ),
                                      ),
                                      child: Center(
                                        child: Obx(
                                          () => Text(
                                            '${productDetailController.imageIndex.value}/${productDetailController.imageProductCount.value}',
                                            style: TextStyle(
                                              color: const Color.fromARGB(
                                                      255, 0, 0, 0)
                                                  .withOpacity(0.7),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 0.5,
                        thickness: 0.5,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // ** Ini dipakai ketika productDetailData sudah selesai di-load
                      Obx(
                        () => productDetailController
                                    .isLoadingFetchDataProduct.value
                            ? const ShimmerProductDetail()
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Text(
                                            productDetailController
                                                .productDetailData[0].nama
                                                .trim(),
                                            maxLines: 3,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            ProductRating(
                                                rating: productDetailController
                                                    .productDetailData[0]
                                                    .rating),
                                            productDetailController
                                                        .productDetailData[0]
                                                        .jumlahRating ==
                                                    '0'
                                                ? const SizedBox()
                                                : Text(
                                                    '(${productDetailController.productDetailData[0].jumlahRating})',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      priceFormatter(productDetailController
                                          .productDetailData[0].harga),
                                      style: TextStyle(
                                        color: ColorPalette().primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: HexColor('#f0f2f5'),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Deskripsi Produk',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AutoSizeText(
                                          productDetailController
                                              .productDetailData[0].deskripsi
                                              .trim(),
                                          maxLines: 5,
                                          maxFontSize: 13,
                                          minFontSize: 13,
                                          // Jika memakai AutoSizeText, maka overflow tidak bisa digunakan
                                          // overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 13,
                                          ),
                                          overflowReplacement: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Obx(
                                                () => Text(
                                                  productDetailController
                                                      .productDetailData[0]
                                                      .deskripsi
                                                      .trim(),
                                                  maxLines:
                                                      productDetailController
                                                          .maxLine,
                                                  overflow:
                                                      productDetailController
                                                          .overflow[0],
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  productDetailController
                                                          .isShowAllDescription
                                                          .value
                                                      ? productDetailController
                                                          .showLessDescription()
                                                      : productDetailController
                                                          .showAllDescription();
                                                },
                                                child: Obx(
                                                  () => Text(
                                                    productDetailController
                                                            .isShowAllDescription
                                                            .value
                                                        ? 'Lebih Sedikit'
                                                        : 'Baca Selengkapnya',
                                                    style: TextStyle(
                                                      color: ColorPalette()
                                                          .primary,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: MerkStokWeightProduct(
                                        product: productDetailController
                                            .productDetailData[0]),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    color: HexColor('#eff4f8'),
                                    height: 8,
                                    thickness: 8,
                                  ),
                                  Obx(
                                    () => shopInfoProductController
                                            .isLoading.value
                                        ? const ShopInfoShimmer()
                                        : shopInfoProductController
                                                .shopInfo.isNotEmpty
                                            ? ShopInfo(
                                              idUserToko: shopInfoProductController
                                                    .shopInfo[0]!.idUser,
                                                namaToko:
                                                    shopInfoProductController
                                                        .shopInfo[0]!.namaToko,
                                                lokasiToko:
                                                    shopInfoProductController
                                                        .shopInfo[0]!.kotaToko,
                                                image: shopInfoProductController
                                                    .shopInfo[0]!.fotoUser,
                                                rating:
                                                    shopInfoProductController
                                                        .shopInfo[0]!
                                                        .totalRating,
                                                jumlahProduk:
                                                    shopInfoProductController
                                                        .shopInfo[0]!
                                                        .totalProduk,
                                                        jumlahRating: shopInfoProductController
                                                        .shopInfo[0]!
                                                        .jumlahRating,
                                              )
                                            : const ShopInfoShimmer(),
                                  ),
                                  Divider(
                                    color: HexColor('#eff4f8'),
                                    height: 8,
                                    thickness: 8,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ProductReview(
                                    rating: productDetailController
                                        .productDetailData[0].rating,
                                    jumlahRating: productDetailController
                                        .productDetailData[0].jumlahRating,
                                    jumlahUlasan: productDetailController
                                        .productDetailData[0].jumlahUlasan,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (userProfileController.idUser != idUser)
            Obx(
              () => productDetailController.isLoadingFetchDataProduct.value
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: HexColor('#fefeff'),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: BuyButton(
                                onPressed: () {
                                  if (login) {
                                    // ** Ini dipakai ketika shopinfo sudah selesai di-load
                                    if (!shopInfoProductController
                                        .isLoading.value) {
                                      Get.to(
                                        () => CheckoutScreen(
                                          product: productDetailController
                                              .productDetailData[0],
                                          shopName: shopInfoProductController
                                              .shopInfo[0]!.namaToko,
                                          stockProduct: productDetailController
                                              .stockProduct.value,
                                        ),
                                        transition: Transition.rightToLeft,
                                        fullscreenDialog: true,
                                        popGesture: false,
                                      );
                                    } else {
                                      shopInfoProductController
                                          .needAwait.value = true;
                                      shopInfoProductController
                                          .needMoveScreen.value = true;

                                      ever(shopInfoProductController.needAwait,
                                          (callback) {
                                        if (!callback &&
                                            shopInfoProductController
                                                .needMoveScreen.value) {
                                          Get.to(
                                            () => CheckoutScreen(
                                              product: productDetailController
                                                  .productDetailData[0],
                                              shopName:
                                                  shopInfoProductController
                                                      .shopInfo[0]!.namaToko,
                                              stockProduct:
                                                  productDetailController
                                                      .stockProduct.value,
                                            ),
                                            transition: Transition.rightToLeft,
                                            fullscreenDialog: true,
                                            popGesture: false,
                                          );
                                        }
                                      });
                                    }
                                  } else {
                                    Get.to(
                                      () => const LoginScreen(),
                                      transition: Transition.rightToLeft,
                                      fullscreenDialog: true,
                                      popGesture: false,
                                    );
                                  }
                                },
                              ),
                            ),
                            const WidthBox(10),
                            Expanded(
                              child: CartButton(
                                onPressed: () {
                                  if (login) {
                                  } else {
                                    Get.to(
                                      () => const LoginScreen(),
                                      transition: Transition.rightToLeft,
                                      fullscreenDialog: true,
                                      popGesture: false,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            )
        ],
      ),
    );
  }
}

class ProductRating extends StatelessWidget {
  const ProductRating({super.key, required this.rating});

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 25,
          width: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color:
                    rating == '0.0000' ? Colors.grey[400] : HexColor('#FFC107'),
                size: 15,
              ),
              const SizedBox(width: 3),
              Text(
                rating == '0.0000' ? '0.0' : ('${double.parse(rating)}'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
