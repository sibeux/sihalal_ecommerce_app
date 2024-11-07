import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/seller_product_controller.dart';

void showModalDeleteProduct(String idProduct) {
  final sellerProductController = Get.put(SellerProductController());
  Get.dialog(
    name: 'Dialog Delete Product',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 100),
    AlertDialog(
      backgroundColor: HexColor('#fefffe'),
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      actionsPadding: const EdgeInsets.only(top: 10),
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 10,
      ),
      content: Text(
        'Yakin ingin menghapus produk ini?',
        style: TextStyle(
          fontSize: 13,
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            const Divider(
              height: 0.4,
              thickness: 0.4,
            ),
            SizedBox(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Batalkan',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // *** verticalDivider baru muncul jika row di-wrap sizebox + height
                  // Intinya tinggi harus diatur
                  const VerticalDivider(
                    width: 0.9,
                    thickness: 0.9,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        Get.back();
                        await sellerProductController.deleteSellerProduct(
                            idProduct: idProduct);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Tetap Hapus',
                          style: TextStyle(
                            color: ColorPalette().primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  ).then((value) => Get.delete<SellerProductController>());
}
