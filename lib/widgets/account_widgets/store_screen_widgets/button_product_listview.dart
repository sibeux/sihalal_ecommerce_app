import 'package:flutter/material.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/store_screen_widgets/alert_modal/change_visibility_modal.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/store_screen_widgets/alert_modal/delete_product_modal.dart';

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
    return ElevatedButton(
      onPressed: () {
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
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
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
