import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/receipt_district.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReceiptDistrictScreen extends StatelessWidget {
  const ReceiptDistrictScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.find<NewAddressController>();
    if (!newAddressController.postalCodeIsSet.value) {
      newAddressController.clearSelectedAddress();
    }
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      resizeToAvoidBottomInset: false,
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
        title: const Text('Pilih Lokasi'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Obx(
                () => newAddressController.isAddressSetManual.value
                    ? Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Lokasi Terpilih',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    newAddressController.postalCodeIsSet.value =
                                        false;
                                    newAddressController
                                        .isAllLocationSet.value = false;
                                    newAddressController
                                        .isAddressSetManual.value = false;
                                    newAddressController
                                            .listCurrentLocation.value =
                                        newAddressController.listProvince;
                                  },
                                  child: Container(
                                    height: 25,
                                    color: Colors.transparent,
                                    child: Text(
                                      'Atur Ulang',
                                      style: TextStyle(
                                        color: ColorPalette().primary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const HeightBox(20),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((newAddressController
                                                .nowCurrentSelectedAddress
                                                .value ==
                                            'city' ||
                                        newAddressController
                                            .provinceIsSet.value ||
                                        newAddressController
                                            .isAllLocationSet.value))
                                      const BulletSelectedLocation(
                                        area: 'province',
                                      ),
                                    if ((newAddressController
                                                .nowCurrentSelectedAddress
                                                .value ==
                                            'postalCode' ||
                                        newAddressController.cityIsSet.value ||
                                        newAddressController
                                            .isAllLocationSet.value))
                                      const BulletSelectedLocation(
                                        area: 'city',
                                      ),
                                    const ContainerSelectArea(),
                                    const HeightBox(20),
                                    Obx(
                                      () => Text(
                                        !newAddressController
                                                .isAllLocationSet.value
                                            ? newAddressController
                                                        .nowCurrentSelectedAddress
                                                        .value ==
                                                    'province'
                                                ? 'Provinsi'
                                                : newAddressController
                                                            .nowCurrentSelectedAddress
                                                            .value ==
                                                        'city'
                                                    ? 'Kota'
                                                    : 'Kode Pos'
                                            : 'Kode Pos',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UseCurrentLocation(),
                            SizedBox(height: 10),
                            Text(
                              'Provinsi',
                            ),
                          ],
                        ),
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Divider(
                  color: Colors.grey.withOpacity(0.3),
                  thickness: 2,
                  height: 0,
                ),
              )
            ],
          ),
          Expanded(
            child: Obx(
              () => newAddressController.isGetLocationLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: ColorPalette().primary,
                        size: 50,
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          newAddressController.listCurrentLocation.length,
                      itemBuilder: (context, index) {
                        return ListTileLocation(
                          location:
                              newAddressController.listCurrentLocation[index]!,
                        );
                      },
                    ),
            ),
          )
        ],
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

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng _currentPosition =
      const LatLng(-6.200000, 106.816666); // Default lokasi (Jakarta)
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Meminta lokasi pengguna saat aplikasi dimulai
  }

  // Fungsi untuk meminta izin lokasi dan mendapatkan posisi pengguna
  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi tersedia
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Jika tidak aktif, minta pengguna untuk mengaktifkan lokasi
      await Geolocator.openLocationSettings();
      return;
    }

    // Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Jika izin ditolak, tidak bisa lanjut
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Jika pengguna memblokir izin lokasi secara permanen
      return;
    }

    // Jika izin diberikan, dapatkan lokasi saat ini
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _isMapInitialized = true; // Tandai bahwa peta siap untuk di-update
    });

    // Setelah lokasi didapatkan, arahkan peta ke lokasi tersebut
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 15.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('current position: $_currentPosition');
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Peta Lokasi Saya'),
    //   ),
    //   body: _isMapInitialized
    //       ? GoogleMap(
    //           initialCameraPosition: CameraPosition(
    //             target: _currentPosition, // Titik lokasi pengguna
    //             zoom: 15.0,
    //           ),
    //           onMapCreated: (controller) {
    //             mapController = controller;
    //             // Setelah peta dibuat, arahkan ke lokasi pengguna jika sudah didapatkan
    //             mapController!.animateCamera(
    //               CameraUpdate.newLatLngZoom(_currentPosition, 15.0),
    //             );
    //           },
    //         )
    //       : const Center(
    //           child:
    //               CircularProgressIndicator()), // Menampilkan loading sampai lokasi didapat
    // );
    return LocationExample(
      currentPositin: _currentPosition,
    );
  }
}

class LocationExample extends StatefulWidget {
  const LocationExample({super.key, required this.currentPositin});

  final LatLng currentPositin;

  @override
  _LocationExampleState createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  String _address = "";

  @override
  void initState() {
    super.initState();
    // Ganti dengan posisi yang didapat
    LatLng currentPosition = const LatLng(-8.1765052, 113.7204491);
    _getAddressFromLatLng(currentPosition.latitude, currentPosition.longitude);
  }

  // Mendapatkan alamat dari latitude dan longitude
  void _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      // Melakukan reverse geocoding
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      // Menampilkan hasil alamat
      setState(() {
        _address =
            "${place.name}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Example'),
      ),
      body: Center(
        child: Text(_address.isNotEmpty ? _address : "Mendapatkan lokasi..."),
      ),
    );
  }
}
