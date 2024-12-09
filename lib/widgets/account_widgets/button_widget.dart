import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/map_geolocation_controller.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/send_user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/address_screen/pin_point_map_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/edit_profile_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/user_auth_screen/login_screen.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/user_auth_screen/register_email_screen.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userProfileController = Get.find<UserProfileController>();
    return ElevatedButton(
      onPressed: () {
        Get.to(
          () => EditProfilScreen(
            name: userProfileController.userData[0].nameUser,
            email: userProfileController.userData[0].emailuser,
            photoUri: userProfileController.userData[0].fotoUser,
          ),
          transition: Transition.downToUp,
          popGesture: false,
          fullscreenDialog: true,
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorPalette().primary,
        elevation: 0, // Menghilangkan shadow
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.4,
          40,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: AutoSizeText(
          'Ubah Profil',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          maxFontSize: 14,
          minFontSize: 10,
        ),
      ),
    );
  }
}

class LoginRegisterProfileButton extends StatelessWidget {
  const LoginRegisterProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const LoginScreen(),
                  transition: Transition.native,
                  popGesture: false,
                  fullscreenDialog: true,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorPalette().primary,
                elevation: 0, // Menghilangkan shadow
                splashFactory: InkRipple.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12.0,
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const RegisterEmailScreen(),
                  transition: Transition.native,
                  popGesture: false,
                  fullscreenDialog: true,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: ColorPalette().primary,
                backgroundColor: Colors.transparent,
                elevation: 0, // Menghilangkan shadow
                splashFactory: InkRipple.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ColorPalette().primary,
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12.0,
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EnableSendNewAddress extends StatelessWidget {
  const EnableSendNewAddress({
    super.key,
    required this.isNewAddress,
    required this.index,
  });

  final bool isNewAddress;
  final int index;

  @override
  Widget build(BuildContext context) {
    final sendUserAddressController = Get.put(SendUserAddressController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AddressButtonWidget(
        title: 'Simpan Alamat',
        icon: Icons.save,
        foregroundColor: Colors.white,
        backgroundColor: ColorPalette().primary,
        onPressed: () async {
          await sendUserAddressController.sendAddress(
            isNewAddress,
            index,
          );
        },
      ),
    );
  }
}

class DisableSendNewAddress extends StatelessWidget {
  const DisableSendNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AddressButtonWidget(
          onPressed: () {},
          title: 'Simpan Alamat',
          icon: Icons.save,
          foregroundColor: HexColor('#a8b5c8'),
          backgroundColor: HexColor('#e5eaf5'),
        ),
      ),
    );
  }
}

class UseCurrentLocationEnable extends StatelessWidget {
  const UseCurrentLocationEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final mapGeolocationController = Get.find<MapGeolocationController>();
    return AddressButtonWidget(
      onPressed: () {
        mapGeolocationController.getPosition();
      },
      title: 'Gunakan Lokasi Saat Ini',
      icon: Icons.location_on,
      foregroundColor: Colors.white,
      backgroundColor: ColorPalette().primary,
    );
  }
}

class UseCurrentLocationDisable extends StatelessWidget {
  const UseCurrentLocationDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: AddressButtonWidget(
        onPressed: () {},
        title: 'Gunakan Lokasi Saat Ini',
        icon: Icons.location_on,
        foregroundColor: HexColor('#a8b5c8'),
        backgroundColor: HexColor('#e5eaf5'),
      ),
    );
  }
}

class SetPinPointEnable extends StatelessWidget {
  const SetPinPointEnable({super.key});

  @override
  Widget build(BuildContext context) {
    final mapGeolocationController = Get.find<MapGeolocationController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      child: AddressButtonWidget(
        onPressed: () async {
          await mapGeolocationController.getCurrentLatLng(
            needFetchMap: true,
          );
          if (mapGeolocationController.address.isEmpty) {
            return;
          }
          Get.to(
            () => const PinPointMapScreen(),
            transition: Transition.native,
            popGesture: false,
            fullscreenDialog: true,
          );
        },
        title: 'Atur Pin Peta',
        icon: Icons.location_pin,
        foregroundColor: Colors.white,
        backgroundColor: ColorPalette().primary,
      ),
    );
  }
}

class SetPinPointDisable extends StatelessWidget {
  const SetPinPointDisable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
      child: AbsorbPointer(
        child: AddressButtonWidget(
          onPressed: () {},
          title: 'Atur Pin Peta',
          icon: Icons.location_pin,
          foregroundColor: HexColor('#a8b5c8'),
          backgroundColor: HexColor('#e5eaf5'),
        ),
      ),
    );
  }
}

class AddressButtonWidget extends StatelessWidget {
  const AddressButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final void Function() onPressed;
  final String title;
  final IconData icon;
  final Color foregroundColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        elevation: 0, // Menghilangkan shadow
        splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: foregroundColor.withOpacity(0.7),
          ),
        ),
        minimumSize: const Size(
          double.infinity,
          40,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
