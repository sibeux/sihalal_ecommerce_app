import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/checkout_controller.dart';
import 'package:sihalal_ecommerce_app/models/product.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.product,
    required this.shopName,
  });

  final Product product;
  final String shopName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Ionicons.storefront_sharp,
                color: ColorPalette().primary,
                size: 18,
              ),
              const WidthBox(10),
              Text(
                shopName,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          const HeightBox(20),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: product.foto1,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.medium,
                      maxHeightDiskCache: 300,
                      maxWidthDiskCache: 300,
                      placeholder: (context, url) => Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const WidthBox(10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.nama,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const HeightBox(15),
                      Text(
                        priceFormat(product.harga),
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const HeightBox(15),
                      const Expanded(
                        child: ButtonQuantity(),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonQuantity extends StatelessWidget {
  const ButtonQuantity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final checkoutController = Get.put(CheckoutController());
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            checkoutController.decrement();
          },
          child: Obx(() => Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: checkoutController.quantity.value == 1
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.remove,
                  color: checkoutController.quantity.value == 1
                      ? Colors.grey
                      : Colors.red,
                  size: 16,
                ),
              )),
        ),
        const WidthBox(10),
        Container(
          height: 30,
          width: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Obx(() => Text(
                checkoutController.quantity.value.toString(),
                style: TextStyle(
                  color: ColorPalette().primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              )),
        ),
        const WidthBox(10),
        GestureDetector(
          onTap: () {
            checkoutController.increment();
          },
          child: Obx(() => Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: checkoutController.quantity.value == 99
                      ? Colors.grey.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  Icons.add,
                  color: checkoutController.quantity.value == 99
                      ? Colors.grey
                      : Colors.blue,
                  size: 16,
                ),
              )),
        ),
      ],
    );
  }
}
