import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/map_geolocation_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';

class PinPointMapScreen extends StatelessWidget {
  const PinPointMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapGeolocationController mapGeolocationController =
        Get.put(MapGeolocationController());

    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Atur Peta Lokasi'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment:
                  Alignment.center, // Untuk menjaga marker tetap di tengah
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: mapGeolocationController.selectedLocation.value ??
                        mapGeolocationController.currentPosition,
                    zoom: 16.0,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    mapGeolocationController.mapController = controller;
                  },
                  onCameraMove: (CameraPosition position) {
                    mapGeolocationController.currentPosition = position.target;
                    if (kDebugMode) {
                      print('Posisi tengah: ${position.target}');
                    }
                  },
                  zoomControlsEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  fortyFiveDegreeImageryEnabled: true,
                ),
                Icon(
                  Icons.location_pin,
                  size: 50,
                  color: ColorPalette().primary,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
              color: HexColor('#fefeff'),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: AddressButtonWidget(
              onPressed: () {
                mapGeolocationController.centerPosition.value =
                    mapGeolocationController.currentPosition;

                mapGeolocationController.selectedLocation.value =
                    mapGeolocationController.centerPosition.value;

                if (mapGeolocationController.selectedLocation.value != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(
                          'Lokasi disimpan: ${mapGeolocationController.selectedLocation.value}'),
                    ),
                  );
                }

                // Pindahkan kamera ke posisi baru setelah diperbarui
                if (mapGeolocationController.mapController != null) {
                  mapGeolocationController.mapController?.animateCamera(
                    CameraUpdate.newLatLng(
                        mapGeolocationController.centerPosition.value),
                  );
                }

                Get.back();
              },
              title: 'Simpan Lokasi',
              icon: Icons.save,
              foregroundColor: Colors.white,
              backgroundColor: ColorPalette().primary,
            ),
          ),
        ],
      ),
    );
  }
}
