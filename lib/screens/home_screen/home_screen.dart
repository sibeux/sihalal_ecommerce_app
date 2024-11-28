import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/product_controller/get_scroll_product_controller.dart';
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
            // onLoading: getScrollLeftProductController.onLoading,
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
            // Awalnya pakai SingleChildScrollView,
            // tapi karena ada SmartRefresher, maka pakai ListView,
            // agar ScrollConfiguration bisa berfungsi.
            child: ListView(
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
                const LeftProductCardRowScroll(
                  color: Color.fromARGB(255, 236, 255, 237),
                  cardHeader: "Cek Produk Terbaru di SiHALAL",
                  sort: 'recent',
                ),
                const SizedBox(height: 25),
                const LeftProductCardRowScroll(
                  color: Color.fromARGB(255, 255, 253, 236),
                  cardHeader: "Mau Beli Apa Hari Ini?",
                  sort: 'random',
                ),
                const SizedBox(height: 25),
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
