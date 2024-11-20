import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';
import 'package:sihalal_ecommerce_app/controller/order_controller.dart';
import 'package:sihalal_ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:sihalal_ecommerce_app/screens/favorite_screen/favorite_screen.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:sihalal_ecommerce_app/screens/order_screen/order_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/check_valid_login.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';

class PersistenBarScreen extends StatefulWidget {
  const PersistenBarScreen({super.key});

  @override
  State<PersistenBarScreen> createState() => _PersistenBarScreenState();
}

class _PersistenBarScreenState extends State<PersistenBarScreen> {
  late PersistentTabController _controller;
  DateTime? lastPressed;
  int lastSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // Daftar halaman untuk tiap tab
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CartScreen(),
      const FavoriteScreen(),
      const OrderScreen(),
      const CheckValidLoginScreen(),
    ];
  }

  // Item navigasi untuk tiap tab
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      buttonNavBar(
          title: 'Beranda',
          iconActive: Ionicons.home_sharp,
          iconInactive: Ionicons.home_outline),
      buttonNavBar(
          title: 'Keranjang',
          iconActive: Ionicons.cart_sharp,
          iconInactive: Ionicons.cart_outline),
      buttonNavBar(
          title: 'Favorit',
          iconActive: Ionicons.heart_sharp,
          iconInactive: Ionicons.heart_outline),
      buttonNavBar(
          title: 'Pesanan',
          iconActive: Ionicons.receipt_sharp,
          iconInactive: Ionicons.receipt_outline),
      buttonNavBar(
          title: 'Akun',
          iconActive: Ionicons.person_sharp,
          iconInactive: Ionicons.person_outline),
    ];
  }

  PersistentBottomNavBarItem buttonNavBar({
    required String title,
    required IconData iconActive,
    required IconData iconInactive,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(iconActive),
      inactiveIcon: Icon(iconInactive),
      title: title,
      contentPadding: 0,
      iconSize: 20,
      activeColorPrimary: ColorPalette().primary,
      inactiveColorPrimary: Colors.black.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLogoutController = Get.put(UserLogoutController());
    return AbsorbPointer(
      absorbing: userLogoutController.isLoggingOut.value,
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: (index) async {
          final box = GetStorage();
          final isLogin = box.read('login') == true;
          if (index == 3 && !isLogin) {
            _controller.jumpToTab(lastSelectedIndex);

            await Get.to(
              () => const LoginScreen(),
              transition: Transition.rightToLeft,
              fullscreenDialog: true,
              popGesture: false,
            );
          } else if (index == 3 && isLogin && lastSelectedIndex != 3) {
            lastSelectedIndex = index;
            await Get.put(OrderController()).getOrderHistory();
          } else {
            lastSelectedIndex = index;
          }
        },
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: false, // Mengatur tombol back di Android
        resizeToAvoidBottomInset: true,
        stateManagement: true, // Untuk manajemen state dari tiap halaman
        hideNavigationBarWhenKeyboardAppears: false,
        decoration: NavBarDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.grey,
              spreadRadius: 0.2,
              // blurRadius: 0.1,
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(0),
          colorBehindNavBar: Colors.white,
        ),
        onWillPop: (p0) async {
          // Kode ini akan dijalankan saat tombol back ditekan
          final now = DateTime.now();
          const maxDuration = Duration(seconds: 2);
          bool backButtonHasNotBeenPressedOrToast =
              lastPressed == null || now.difference(lastPressed!) > maxDuration;

          if (backButtonHasNotBeenPressedOrToast) {
            lastPressed = DateTime.now(); // Update waktu saat back ditekan

            Fluttertoast.showToast(
              msg: 'Tekan sekali lagi untuk keluar',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black.withOpacity(0.8),
              textColor: Colors.white,
              fontSize: 10.0,
            );

            return Future.value(false); // Tidak keluar dari aplikasi
          }

          // Keluar dari aplikasi
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        },
        navBarStyle: NavBarStyle.style3,
        padding: const EdgeInsets.only(
          bottom: 5,
        ),
      ),
    );
  }
}
