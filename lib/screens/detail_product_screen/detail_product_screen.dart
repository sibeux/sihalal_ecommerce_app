import 'package:auto_size_text/auto_size_text.dart';
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
      backgroundColor: HexColor('#fefeff'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefeff'),
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
                      color: HexColor('#fefeff'),
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
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      product.nama,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      ProductRating(rating: product.rating),
                      product.rating == '0.0000'
                          ? const SizedBox()
                          : Text(
                              '(${product.jumlahUlasan})',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                priceFormat(product.harga),
                style: TextStyle(
                  color: HexColor('#3f44a6'),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    product.deskripsi,
                    maxLines: 5,
                    maxFontSize: 14,
                    minFontSize: 14,
                    // Jika memakai AutoSizeText, maka overflow tidak bisa digunakan
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    overflowReplacement: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              product.deskripsi,
                              maxLines: productDetailController.maxLine,
                              overflow: productDetailController.overflow[0],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            productDetailController.isShowAllDescription.value
                                ? productDetailController.showLessDescription()
                                : productDetailController.showAllDescription();
                          },
                          child: Obx(() => Text(
                                productDetailController
                                        .isShowAllDescription.value
                                    ? 'Lebih Sedikit'
                                    : 'Baca Selengkapnya',
                                style: TextStyle(
                                  color: HexColor('#3f44a6'),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        )
                      ],
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
        SizedBox(
            height: 25,
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: HexColor('#fec101'), size: 15),
                const SizedBox(width: 3),
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
