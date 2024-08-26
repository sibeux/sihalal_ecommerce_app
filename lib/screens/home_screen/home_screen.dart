import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/banner_slider.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/categories.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/product_card_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final iconList = <IconData>[
  Icons.brightness_5,
  Icons.brightness_4,
  Icons.brightness_6,
  Icons.brightness_7,
];

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final searchProductController = Get.put(SearchProductController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[HexColor('#C47DFE'), HexColor('#C47DFE')]),
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
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            hintText: 'Cari produk halal di SiHALAL',
            hintStyle: TextStyle(color: HexColor('#8D1EE4'), fontSize: 12),
            // * agar textfield tidak terlalu lebar, maka dibuat constraints
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
              color: HexColor('#8D1EE4'),
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
            width: 10,
          ),
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              BannerSlider(),
              SizedBox(
                height: 20,
              ),
              Categories(),
              SizedBox(height: 30),
              ProductCardRowScroll(
                color: '#C47DFE',
                cardHeader: "Cek Produk Terbaru di SiHALAL",
                sort: 'recent',
              ),
            ],
          ),
        ),
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
