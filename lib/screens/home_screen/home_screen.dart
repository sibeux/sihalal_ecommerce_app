import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_scroll_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/search_product_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/banner_slider.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/categories.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/infinite_vertical_product/vertical_product_scroll.dart';
import 'package:sihalal_ecommerce_app/widgets/home_widgets/product_card_scroll/left_product_card_scroll.dart';
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
    final getScrollProductController = Get.put(GetScrollProductController());
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
            onTap: () {
              Get.find<SearchProductController>().onClear();
              Get.to(
                () => const SearchProductScreen(),
                transition: Transition.rightToLeft,
              );
            },
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
          AbsorbPointer(
            absorbing: true,
            // absorbing: false,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: UserPhotoAppbar(),
                ),
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: ColorPalette().primary,
          child: SmartRefresher(
            controller: getScrollProductController.refreshController,
            onRefresh: getScrollProductController.onRefresh,
            // onLoading itu ketika pull up / footer ditarik
            onLoading: getScrollProductController.onLoading,
            enablePullDown: true,
            enablePullUp: true,
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
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              height: 60,
              loadingText: 'Memuat...',
              textStyle: TextStyle(
                color: ColorPalette().primary,
                fontSize: 12,
              ),
              idleText: 'Tarik ke atas untuk memuat lebih banyak',
              noDataText: 'Tidak ada data lagi',
              failedText: 'Gagal memuat',
              canLoadingText: 'Lepaskan untuk memuat lebih banyak',
              idleIcon: Icon(
                Icons.arrow_upward,
                color: ColorPalette().primary,
              ),
            ),
            // Awalnya pakai SingleChildScrollView,
            // tapi karena ada SmartRefresher, maka pakai ListView,
            // agar ScrollConfiguration bisa berfungsi.
            child: ListView(
              children: const <Widget>[
                SizedBox(
                  height: 5,
                ),
                BannerSlider(),
                SizedBox(
                  height: 20,
                ),
                Categories(),
                SizedBox(height: 25),
                LeftProductCardRowScroll(
                  color: Color.fromARGB(255, 236, 255, 237),
                  cardHeader: "Cek Produk Terbaru di SiHALAL",
                  sort: 'recent',
                ),
                SizedBox(height: 25),
                LeftProductCardRowScroll(
                  color: Color.fromARGB(255, 255, 253, 236),
                  cardHeader: "Rekomendasi Produk Hari Ini",
                  sort: 'random',
                ),
                SizedBox(height: 25),
                VerticalProductScroll(),
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
