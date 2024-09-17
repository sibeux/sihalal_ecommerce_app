import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/banner_slider.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/categories.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/widgets/product_card_scroll.dart';
import 'package:sihalal_ecommerce_app/screens/search_product_screen/search_product_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final iconList = <IconData>[
  Icons.home,
  Icons.book,
  Icons.brightness_6,
  Icons.person,
];

final labelList = <String>[
  'Home',
  'Category',
  'Wishlist',
  'Akun',
];

const String colorWhite = 'fefffe';

class NoGlowScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(colorWhite),
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
        title: GestureDetector(
          onTap: () => Get.to(
            () => const SearchProductScreen(),
            transition: Transition.rightToLeft,
          ),
          child: AbsorbPointer(
            child: TextFormField(
              cursorColor: HexColor('#575757'),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: HexColor('#575757'), fontSize: 12),
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: HexColor(colorWhite),
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
                enabledBorder: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
              ),
            ),
          ),
        ),
        actions: [
          const Icon(
            Icons.shopping_cart_checkout_sharp,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: (){
              Get.to(() => const LoginScreen());
            },
            child: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor(colorWhite),
        selectedItemColor: HexColor('#C47DFE'),
        unselectedItemColor: HexColor('#575757'),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: iconList
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e),
                label: labelList[iconList.indexOf(e)],
              ),
            )
            .toList(),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: HexColor('#C47DFE'),
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
                SizedBox(height: 25),
                ProductCardRowScroll(
                  color: '#C47DFE',
                  cardHeader: "Cek Produk Terbaru di SiHALAL",
                  sort: 'recent',
                ),
              ],
            ),
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
