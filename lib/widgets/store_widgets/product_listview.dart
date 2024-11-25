import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/screens/product_detail_screen/product_detail_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/button_product_listview.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductListview extends StatelessWidget {
  const ProductListview({
    super.key,
    required this.listData,
  });

  final List listData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listData.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index == listData.length
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(
                  child: Text("Tidak ada produk lainnya"),
                ),
              )
            : Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.to(
                          () => ProductDetailScreen(
                            idProduk: listData[index].uidProduct,
                            idUser: listData[index].uidUser,
                            fotoImage1: listData[index].foto1,
                          ),
                          transition: Transition.rightToLeft,
                          fullscreenDialog: true,
                          popGesture: false,
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Colors.black.withOpacity(0.3),
                                width: 0.3,
                              ),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: listData[index].foto1,
                              height: 80,
                              width: 80,
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover,
                              maxHeightDiskCache: 200,
                              maxWidthDiskCache: 200,
                            ),
                          ),
                          const WidthBox(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listData[index].nama,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const HeightBox(10),
                                Text(
                                  priceFormatter(listData[index].harga),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const HeightBox(10),
                    const Divider(
                      height: 0.3,
                      thickness: 0.3,
                    ),
                    const HeightBox(10),
                    StaggeredGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 10,
                      axisDirection: AxisDirection.down,
                      children: [
                        GridviewProductData(
                          title: 'Stok ${listData[index].stok}',
                          icon: Ionicons.cube_outline,
                        ),
                        GridviewProductData(
                          title: 'Terjual ${listData[index].countSold}',
                          icon: Ionicons.basket_outline,
                        ),
                        GridviewProductData(
                          title: 'Favorit ${listData[index].stok}',
                          icon: Ionicons.heart_outline,
                        ),
                        GridviewProductData(
                          title: 'Ulasan ${listData[index].countReview}',
                          icon: Ionicons.star_outline,
                        ),
                      ],
                    ),
                    const HeightBox(10),
                    const Divider(
                      height: 0.3,
                      thickness: 0.3,
                    ),
                    const HeightBox(10),
                    Row(
                      children: [
                        Expanded(
                          child: ChangeStatusButton(
                            idProduct: listData[index].uidProduct,
                            title: listData[index].isVisible
                                ? 'Arsipkan'
                                : 'Tampilkan',
                          ),
                        ),
                        const WidthBox(10),
                        Expanded(
                          child: EditButton(
                            sellerProduct: listData[index],
                          ),
                        ),
                        const WidthBox(10),
                        DeleteButton(
                          idProduct: listData[index].uidProduct,
                        ),
                      ],
                    )
                  ],
                ),
              );
      },
    );
  }
}

class GridviewProductData extends StatelessWidget {
  const GridviewProductData({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 18,
          ),
          const WidthBox(5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
