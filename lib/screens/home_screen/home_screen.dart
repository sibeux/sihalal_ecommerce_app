import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_scroll_left_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/checkout_screen/order_placed_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/banner_slider.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/categories.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/product_card_scroll.dart';
import 'package:sihalal_ecommerce_app/screens/search_product_screen/search_product_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/photo_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

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
    Get.put(UserProfileController());
    final getScrollLeftProductController =
        Get.put(GetScrollLeftProductController());
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
                HexColor('#519756').withOpacity(0.6),
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
              Get.to(
                () => const OrderPlacedScreen(),
                transition: Transition.rightToLeft,
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: UserPhotoAppbar(),
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SmartRefresher(
        controller: getScrollLeftProductController.refreshController,
        onRefresh: getScrollLeftProductController.onRefresh,
        // onLoading itu ketika pull up / footer ditarik
        onLoading: getScrollLeftProductController.onLoading,
        enablePullDown: true,
        enablePullUp: false,
        header: ClassicHeader(
          height: 40,
          refreshStyle: RefreshStyle.Follow,
          refreshingIcon: SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: ColorPalette().primary,
              strokeWidth: 2,
            ),
          ),
          releaseText: 'Lepaskan untuk memuat ulang',
          refreshingText: 'Memuat ulang...',
          completeText: 'Selesai',
          idleText: 'Tarik ke bawah untuk memuat ulang',
          failedText: 'Gagal memuat ulang',
          textStyle: TextStyle(
            color: ColorPalette().primary,
            fontSize: 12,
          ),
        ),
        child: ScrollConfiguration(
          // aslinya ini agar tidak ada efek meregang
          // tapi karena pakai refresh pull, maka percuma
          // Mirip saat discroll mentok ke kanan atau ke kiri
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
