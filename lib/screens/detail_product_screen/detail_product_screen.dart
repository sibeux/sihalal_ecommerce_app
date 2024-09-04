import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
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
                  )
                ],
              ),
              const SizedBox(height: 10),
              
            ],
          ),
        ));
  }
}
