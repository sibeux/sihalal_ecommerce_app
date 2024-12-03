import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/favorite_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/infinite_vertical_product/vertical_product_card.dart';
import 'package:velocity_x/velocity_x.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());
    favoriteController.readFavorite();
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Favorite'),
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Obx(
                  () => favoriteController.isLoadingFetchFavorite.value
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            MasonryGridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 5,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  favoriteController.listFavoriteProduct.length,
                              itemBuilder: (context, index) {
                                return VerticalProductCard(
                                  idProduct: favoriteController
                                      .listFavoriteProduct[index].uidProduct,
                                  idUser: favoriteController
                                      .listFavoriteProduct[index].uidUser,
                                  title: favoriteController
                                      .listFavoriteProduct[index].nama,
                                  rating: favoriteController
                                      .listFavoriteProduct[index].rating,
                                  description: favoriteController
                                      .listFavoriteProduct[index].deskripsi,
                                  image: favoriteController
                                      .listFavoriteProduct[index].foto1,
                                  kota: favoriteController
                                      .listFavoriteProduct[index].kota,
                                  stok: favoriteController
                                      .listFavoriteProduct[index].stok,
                                  price: double.parse(
                                    favoriteController
                                        .listFavoriteProduct[index].harga,
                                  ),
                                  isFavorite: favoriteController
                                      .listFavoriteProduct[index].isFavorite,
                                  screenFrom: 'home_favorite',
                                );
                              },
                            ),
                            const HeightBox(25),
                            Center(
                              child: Text(
                                'Tidak ada data lainnya',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
