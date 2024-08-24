import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProductController = Get.put(SearchProductController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[HexColor('C86DD7'), HexColor('683EBC')]),
          ),
        ),
        titleSpacing: 10,
        title: TextFormField(
          controller: searchProductController.controller,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          onChanged: (value) {
            searchProductController.onChanged(value);
          },
          style: TextStyle(color: HexColor('#575757'), fontSize: 12),
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            fillColor: HexColor('#f1f1f1'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            hintText: 'Cari produk halal di SiHALAL',
            hintStyle: TextStyle(color: HexColor('#909191'), fontSize: 12),
            // agar textfield tidak terlalu lebar, maka dibuat constraints
            suffixIconConstraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 20,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 30,
              minHeight: 20,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: HexColor('#575757'),
            ),
            suffixIcon: Obx(() => searchProductController.isTypingValue
                ? GestureDetector(
                    onTap: () {
                      searchProductController.controller.clear();
                      searchProductController.onChanged('');
                    },
                    child: Icon(
                      Icons.close,
                      color: HexColor('#575757'),
                    ),
                  )
                : const SizedBox.shrink()),
            enabledBorder: outlineInputBorder(),
            focusedBorder: outlineInputBorder(),
          ),
        ),
        actions: const [
          Icon(
            Icons.shopping_cart_rounded,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.message_rounded,
            color: Colors.white,
          ),
          SizedBox(
            width: 50,
          )
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Welcome to Home Screen'),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(5),
  );
}
