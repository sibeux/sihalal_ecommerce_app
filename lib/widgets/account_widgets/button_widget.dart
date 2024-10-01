import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/map_geolocation_controller.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorPalette().primary,
          elevation: 0, // Menghilangkan shadow
          splashFactory: InkRipple.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(
            double.infinity,
            40,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 12.0,
          ),
          child: Text(
            'Ubah Profil',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
