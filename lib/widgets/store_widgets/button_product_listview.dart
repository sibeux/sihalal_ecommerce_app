import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/models/seller_product.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/store_centre_screen/add_product_screen/add_product_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/alert_modal_dialog/change_visibility_modal.dart';
import 'package:sihalal_ecommerce_app/widgets/store_widgets/alert_modal_dialog/delete_product_modal.dart';

class ChangeStatusButton extends StatelessWidget {
  const ChangeStatusButton({
    super.key,
    required this.title,
    required this.idProduct,
  });

  final String idProduct;
  final String title;

  @override
  Widget build(BuildContext context) {
    final userAddressController = Get.find<UserAddressController>();
    return ElevatedButton(
      onPressed: () {
        if (userAddressController.addressList.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Tambahkan alamat toko terlebih dahulu',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black.withOpacity(1),
            textColor: Colors.white,
            fontSize: 10.0,
          );
          return;
        }
        if (title == 'Tampilkan') {
          showModalChangeVisibiltyProduct(
            idProduct: idProduct,
            title: 'Yakin untuk tampilkan produk?',
            visibility: 'true',
          );
        } else {
          showModalChangeVisibiltyProduct(
            idProduct: idProduct,
            title: 'Yakin untuk arsipkan produk?',
            visibility: 'false',
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0, // Menghilangkan shadow
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        minimumSize: const Size(
          double.infinity,
          40,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.sellerProduct,
  });

  final SellerProduct sellerProduct;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(
          () => const AddProductScreen(),
          transition: Transition.rightToLeft,
          fullscreenDialog: true,
          popGesture: false,
          arguments: sellerProduct,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorPalette().primary,
        backgroundColor: Colors.white,
        elevation: 0, // Menghilangkan shadow
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: ColorPalette().primary,
          ),
        ),
        minimumSize: const Size(
          double.infinity,
          40,
        ),
      ),
      child: const Text(
        'Ubah',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.idProduct});

  final String idProduct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalDeleteProduct(
          idProduct,
        );
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        child: Icon(
          Icons.delete_forever_outlined,
          color: Colors.red.withOpacity(0.7),
        ),
      ),
    );
  }
}
