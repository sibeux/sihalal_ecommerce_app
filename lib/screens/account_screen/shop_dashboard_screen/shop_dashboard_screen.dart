import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/shop_dashboard_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/infinite_vertical_product/vertical_product_card.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shimmer_product_card.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/shrink_tap_card.dart';
import 'package:velocity_x/velocity_x.dart';

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class ShopDashboardScreen extends StatelessWidget {
  const ShopDashboardScreen({
    super.key,
    required this.idUserToko,
    required this.namaToko,
    required this.fotoToko,
    required this.lokasiToko,
    required this.ratingToko,
    required this.jumlahRating,
  });

  final String idUserToko;
  final String namaToko, fotoToko, lokasiToko;
  final String ratingToko, jumlahRating;

  @override
  Widget build(BuildContext context) {
    final shopDashboardController = Get.put(ShopDashboardController());
    final idUser = Get.find<UserProfileController>().idUser;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      shopDashboardController.fetchProductNow(idUSer: idUserToko);
    });
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 170,
                ),
                Text(
                  namaToko,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const HeightBox(15),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.pin_drop,
                            size: 20,
                            color: ColorPalette().primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              lokasiToko,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.8),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              '$ratingToko ($jumlahRating penilaian)',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.8),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const HeightBox(20),
                SizedBox(
                  height: 8,
                  width: MediaQuery.of(context).size.width,
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    child: Divider(
                      color: HexColor('#eff4f8'),
                      height: 8,
                      thickness: 8,
                    ),
                  ),
                ),
                Expanded(
                  child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    child: ScrollConfiguration(
                      behavior: NoGlowScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: ColorPalette().primary,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeightBox(20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Produk Terlaris',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: idUser != idUserToko ? 380 : 340,
                                child: Obx(
                                  () => shopDashboardController
                                          .isLoadingGetProductMostSold.value
                                      ? AbsorbPointer(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: ShimmerProductCard(
                                              needButtonTambah:
                                                  idUser != idUserToko,
                                              fromShopDashboard: true,
                                            ),
                                          ),
                                        )
                                      : GlowingOverscrollIndicator(
                                          axisDirection: AxisDirection.right,
                                          color: ColorPalette().white,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 20),
                                                for (var product
                                                    in shopDashboardController
                                                        .listProductMostSold)
                                                  ShrinkTapProduct(
                                                    product: product,
                                                    uidProduct:
                                                        product.uidProduct,
                                                    title: product.nama,
                                                    description:
                                                        product.deskripsi,
                                                    price: double.parse(
                                                        product.harga),
                                                    rating: product.rating,
                                                    image: product.foto1,
                                                    fromShopDashboard: true,
                                                    isFavorite: product.isFavorite,
                                                    screenFrom: 'shop_dashboard',
                                                  ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              const HeightBox(15),
                              Divider(
                                color: HexColor('#eff4f8'),
                                height: 8,
                                thickness: 8,
                              ),
                              const HeightBox(20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Semua Produk',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Obx(
                                  () => shopDashboardController
                                          .isLoadingGetAllProduct.value
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : MasonryGridView.count(
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 5,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: shopDashboardController
                                              .listAllProduct.length,
                                          itemBuilder: (context, index) {
                                            return VerticalProductCard(
                                              idProduct: shopDashboardController
                                                  .listAllProduct[index]
                                                  .uidProduct,
                                              idUser: shopDashboardController
                                                  .listAllProduct[index]
                                                  .uidUser,
                                              title: shopDashboardController
                                                  .listAllProduct[index].nama,
                                              rating: shopDashboardController
                                                  .listAllProduct[index].rating,
                                              description:
                                                  shopDashboardController
                                                      .listAllProduct[index]
                                                      .deskripsi,
                                              image: shopDashboardController
                                                  .listAllProduct[index].foto1,
                                              kota: shopDashboardController
                                                  .listAllProduct[index].kota,
                                              stok: shopDashboardController
                                                  .listAllProduct[index].stok,
                                              price: double.parse(
                                                shopDashboardController
                                                    .listAllProduct[index]
                                                    .harga,
                                              ),
                                              isFavorite: shopDashboardController
                                                  .listAllProduct[index].isFavorite,
                                              screenFrom: 'shop_dashboard',
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              backgroundColor: ColorPalette().primary,
              toolbarHeight: 100,
              titleSpacing: 0,
              centerTitle: true,
              leading: Column(
                children: [
                  const HeightBox(10),
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              title: Container(
                alignment: Alignment.center,
                width: 180,
                height: 40,
                decoration: BoxDecoration(
                  color: HexColor('#fefffe'),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/splash/splash-text.png'),
                    matchTextDirection: true,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                border: Border.all(
                  color: HexColor('#fefffe'),
                  width: 5,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  imageUrl: fotoToko,
                  filterQuality: FilterQuality.medium,
                  fit: BoxFit.cover,
                  maxWidthDiskCache: 200,
                  maxHeightDiskCache: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
