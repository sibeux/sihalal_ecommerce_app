import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_scroll_product_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/infinite_vertical_product/vertical_product_card.dart';

class VerticalProductScroll extends StatefulWidget {
  const VerticalProductScroll({
    super.key,
  });

  @override
  State<VerticalProductScroll> createState() => _VerticalProductScrollState();
}

class _VerticalProductScrollState extends State<VerticalProductScroll>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final getScrollProductController = Get.find<GetScrollProductController>();
    getScrollProductController.getProduct('recent', isVertical: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => getScrollProductController.isLoadingVerticalRecent.value
            ? const Center(child: CircularProgressIndicator())
            : MasonryGridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    getScrollProductController.verticalRecentProduct.length,
                itemBuilder: (context, index) {
                  return VerticalProductCard(
                    idProduct: getScrollProductController
                        .verticalRecentProduct[index]!.uidProduct,
                    idUser: getScrollProductController
                        .verticalRecentProduct[index]!.uidUser,
                    title: getScrollProductController
                        .verticalRecentProduct[index]!.nama,
                    rating: getScrollProductController
                        .verticalRecentProduct[index]!.rating,
                    description: getScrollProductController
                        .verticalRecentProduct[index]!.deskripsi,
                    image: getScrollProductController
                        .verticalRecentProduct[index]!.foto1,
                    kota: getScrollProductController
                        .verticalRecentProduct[index]!.kota,
                    price: double.parse(getScrollProductController
                        .verticalRecentProduct[index]!.harga),
                    isFavorite: getScrollProductController.verticalRecentProduct[index]!.isFavorite,
                    screenFrom: 'home_vertical',
                  );
                },
              ),
      ),
    );
  }
}
