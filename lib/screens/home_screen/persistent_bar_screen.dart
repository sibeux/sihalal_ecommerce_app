import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/register_email_screen.dart';

class PersistenBarScreen extends StatefulWidget {
  const PersistenBarScreen({super.key});

  @override
  State<PersistenBarScreen> createState() => _PersistenBarScreenState();
}

class _PersistenBarScreenState extends State<PersistenBarScreen> {
  late PersistentTabController _controller;
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // Daftar halaman untuk tiap tab
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const LoginScreen(),
      const RegisterEmailScreen(),
      const RegisterEmailScreen(),
      const RegisterEmailScreen(),
    ];
  }

  // Item navigasi untuk tiap tab
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      buttonNavBar(
          title: 'Beranda',
          iconActive: Icons.home,
          iconInactive: Icons.home_outlined),
      buttonNavBar(
          title: 'Keranjang',
          iconActive: Icons.add_shopping_cart_rounded,
          iconInactive: Icons.add_shopping_cart_outlined),
      buttonNavBar(
          title: 'Favorit',
          iconActive: Icons.favorite_rounded,
          iconInactive: Icons.favorite_border_rounded),
      buttonNavBar(
          title: 'Pesanan',
          iconActive: Icons.notifications_active,
          iconInactive: Icons.notifications),
      buttonNavBar(
          title: 'Akun',
          iconActive: Icons.person_2_rounded,
          iconInactive: Icons.person_2_outlined),
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
      iconSize: 24,
      activeColorPrimary: ColorPalette().primary,
      inactiveColorPrimary: Colors.black.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true, // Mengatur tombol back di Android
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Untuk manajemen state dari tiap halaman
      hideNavigationBarWhenKeyboardAppears:
          false, // Sembunyikan nav bar saat keyboard muncul
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
      onWillPop: (p0) {
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
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black.withOpacity(0.8),
            textColor: Colors.white,
            fontSize: 10.0,
          );

          return Future.value(false); // Tidak keluar dari aplikasi
        }

        // Keluar dari aplikasi
        SystemNavigator.pop();
        return Future.value(true);
      },
      navBarStyle: NavBarStyle.style3,
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
    );
  }
}
