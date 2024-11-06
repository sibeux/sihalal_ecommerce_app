import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/add_product_screen/add_product_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/store_screen_widgets/product_listview.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/store_screen_widgets/status_product_filter.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final getSellerProductController = Get.find<GetSellerProductController>();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    getSellerProductController.changeFilterProductList(0);
    super.initState();

    _tabController.addListener(() {
      getSellerProductController.changeFilterProductList(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: HexColor('#f4f4f5'),
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
              title: const Text('Daftar Produk'),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              actions: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    splashFactory: InkRipple.splashFactory,
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
                      style: TextStyle(
                        color: ColorPalette().primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                indicatorColor: ColorPalette().primary,
                labelColor: ColorPalette().primary,
                controller: _tabController,
                onTap: (value) {
                  getSellerProductController.changeFilterProductList(value);
                },
                tabs: [
                  Obx(
                    () => Tab(
                      child: FilterStatusProduct(
                        title: 'Ditampilkan',
                        count: getSellerProductController.productVisible.value,
                        index: 0,
                      ),
                    ),
                  ),
                  Obx(
                    () => Tab(
                      child: FilterStatusProduct(
                        title: 'Diarsipkan',
                        count:
                            getSellerProductController.productInvisible.value,
                        index: 1,
                      ),
                    ),
                  ),
                  Obx(
                    () => Tab(
                      child: FilterStatusProduct(
                        title: 'Habis',
                        count: getSellerProductController.productOutStock.value,
                        index: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Obx(
              () => getSellerProductController.needRefresh.value ||
                      !getSellerProductController.needRefresh.value
                  ? TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        ProductListview(
                          listData:
                              getSellerProductController.visibleProductList,
                        ),
                        ProductListview(
                          listData:
                              getSellerProductController.invisibleProductList,
                        ),
                        ProductListview(
                          listData:
                              getSellerProductController.outStockProductList,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
          Obx(
            () => getSellerProductController.isGetProductLoading.value
                ? const Opacity(
                    opacity: 0.8,
                    child:
                        ModalBarrier(dismissible: false, color: Colors.black),
                  )
                : const SizedBox(),
          ),
          Obx(
            () => getSellerProductController.isGetProductLoading.value
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white,
                      size: 50,
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
