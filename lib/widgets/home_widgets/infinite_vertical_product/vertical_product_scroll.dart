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
    getScrollProductController.getProduct('random', isVertical: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => getScrollProductController.isLoadingVerticalRandom.value
            ? const Center(child: CircularProgressIndicator())
            : MasonryGridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    getScrollProductController.verticalRandomProduct.length,
                itemBuilder: (context, index) {
                  return VerticalProductCard(
                    idProduct: getScrollProductController
                        .verticalRandomProduct[index]!.uidProduct,
                    idUser: getScrollProductController
                        .verticalRandomProduct[index]!.uidUser,
                    title: getScrollProductController
                        .verticalRandomProduct[index]!.nama,
                    rating: getScrollProductController
                        .verticalRandomProduct[index]!.rating,
                    description: getScrollProductController
                        .verticalRandomProduct[index]!.deskripsi,
                    image: getScrollProductController
                        .verticalRandomProduct[index]!.foto1,
                    kota: getScrollProductController
                        .verticalRandomProduct[index]!.kota,
                    price: double.parse(getScrollProductController
                        .verticalRandomProduct[index]!.harga),
                  );
                },
              ),
      ),
    );
  }
}
