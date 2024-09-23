import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/banner_slider.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/categories.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll.dart';
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
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                HexColor('#519756').withOpacity(0.6),
                HexColor('#f4d68a').withOpacity(0.6),
              ],
            ),
          ),
        ),
        // ini semacam padding untuk title
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: GestureDetector(
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
                  hintStyle:
                      TextStyle(color: ColorPalette().primary, fontSize: 12),
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
                    color: ColorPalette().primary,
                  ),
                  enabledBorder: outlineInputBorder(),
                  focusedBorder: outlineInputBorder(),
                ),
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const LoginScreen());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  imageUrl: '',
                  fit: BoxFit.cover,
                  height: 35,
                  width: 35,
                  maxHeightDiskCache: 100,
                  maxWidthDiskCache: 100,
                  filterQuality: FilterQuality.low,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/shimmer/profile/profile_shimmer.png',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/shimmer/profile/profile_shimmer.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor(colorWhite),
        selectedItemColor: ColorPalette().primary,
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
          color: ColorPalette().primary,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                const BannerSlider(),
                const SizedBox(
                  height: 20,
                ),
                const Categories(),
                const SizedBox(height: 25),
                ProductCardRowScroll(
                  color: HexColor('#ecffef'),
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
