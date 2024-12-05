import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/search_product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/search_product_screen/search_product_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/infinite_vertical_product/vertical_product_card.dart';

class VerticalSearchProduct extends StatelessWidget {
  const VerticalSearchProduct({super.key, required this.keyword});

  final String keyword;

  @override
  Widget build(BuildContext context) {
    final SearchProductController searchProductController =
        Get.find<SearchProductController>();
    return Scaffold(
      backgroundColor: ColorPalette().white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPalette().white,
        surfaceTintColor: Colors.transparent,
        // ini semacam padding untuk title
        titleSpacing: 0,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: ColorPalette().primary,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: () {
              searchProductController.onChanged(keyword);
              Get.to(
                () => const SearchProductScreen(),
                transition: Transition.native,
                fullscreenDialog: true,
                popGesture: false,
              );
            },
            child: AbsorbPointer(
              child: TextFormField(
                cursorColor: HexColor('#575757'),
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: HexColor('#575757'), fontSize: 12),
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: ColorPalette().white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                  hintText: keyword,
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.6), fontSize: 12),
                  // * agar textfield tidak terlalu lebar, maka dibuat constraints
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 20,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 20,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorPalette().primary,
                  ),
                  enabledBorder: outlineInputBorder(),
                  focusedBorder: outlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(
                () => searchProductController.isLoadingReadProduct.value
                    ? const SizedBox()
                    : MasonryGridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            searchProductController.listProductSearch.length,
                        itemBuilder: (context, index) {
                          return VerticalProductCard(
                            idProduct: searchProductController
                                .listProductSearch[index].uidProduct,
                            idUser: searchProductController
                                .listProductSearch[index].uidUser,
                            title: searchProductController
                                .listProductSearch[index].nama,
                            rating: searchProductController
                                .listProductSearch[index].rating,
                            description: searchProductController
                                .listProductSearch[index].deskripsi,
                            image: searchProductController
                                .listProductSearch[index].foto1,
                            kota: searchProductController
                                .listProductSearch[index].kota,
                            stok: searchProductController
                                .listProductSearch[index].stok,
                            price: double.parse(
                              searchProductController
                                  .listProductSearch[index].harga,
                            ),
                            isFavorite: searchProductController
                                .listProductSearch[index].isFavorite,
                            screenFrom: 'shop_vertical_search',
                          );
                        },
                      ),
              ),
            ),
          ),
          Obx(
            () => searchProductController.isLoadingReadProduct.value
                ? const Opacity(
                    opacity: 1,
                    child:
                        ModalBarrier(dismissible: false, color: Colors.white),
                  )
                : const SizedBox(),
          ),
          Obx(
            () => searchProductController.isLoadingReadProduct.value
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: ColorPalette().primary,
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

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: ColorPalette().primary, width: 2),
    borderRadius: const BorderRadius.all(Radius.circular(7)),
  );
}