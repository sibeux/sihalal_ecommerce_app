import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/price_format.dart';
import 'package:sihalal_ecommerce_app/controller/product_detail_controller.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';

final _pageController = PageController(initialPage: 0, viewportFraction: 1);

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    var itemCount = product.foto3 != ""
        ? 3
        : product.foto2 != ""
            ? 2
            : 1;
    var listFoto = [
      product.foto1,
      product.foto2,
      product.foto3,
    ];
    final productDetailController = Get.put(ProductDetailController());
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        title: const Text('Detail Product'),
      ),
      body: SingleChildScrollView(
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
                    child: ScrollConfiguration(
                      behavior: NoGlowScrollBehavior(),
                      child: PageView.builder(
                        itemCount: itemCount,
                        controller: _pageController,
                        onPageChanged: (value) {
                          productDetailController.changeImageIndex(value + 1);
                        },
                        itemBuilder: (context, index) {
                          return CachedNetworkImage(
                            imageUrl: listFoto[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Container(
                    width: 35,
                    height: 20,
                    decoration: BoxDecoration(
                      color: HexColor('#fefefe'),
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                        color: const Color.fromARGB(255, 217, 220, 231),
                        width: 1.1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                    child: Center(
                      child: Obx(() => Text(
                            '${productDetailController.imageIndex.value}/$itemCount',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
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
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      priceFormat(product.harga),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                product.nama,
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ProductRating(rating: product.rating),
                  const SizedBox(width: 2),
                  Text(
                    '${product.jumlahUlasan} Ulasan',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
        Container(
            margin: const EdgeInsets.only(right: 10),
            height: 25,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 217, 220, 231),
                width: 1.1,
                strokeAlign: BorderSide.strokeAlignOutside,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: HexColor('#fec101'), size: 15),
                const SizedBox(width: 6),
                Text(
                  rating == '0.0000' ? '---' : ('${double.parse(rating)}'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
