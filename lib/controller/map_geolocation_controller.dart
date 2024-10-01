import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/models/address_model/geolocation_address.dart';

class MapGeolocationController extends GetxController {
  LatLng _currentPosition = const LatLng(-6.200000, 106.816666);
  var address = RxList<GeolocationAddress?>([]);
  var isLoadingMap = false.obs;

  final NewAddressController newAddressController =
      Get.find<NewAddressController>();

  void getPosition() async {
    isLoadingMap.value = true;
    await getCurrentLocation();
    final geoProvince = address[0]!.nameProvince;
    final geoCity = address[0]!.nameCity;

    final splitLocation = geoCity.split(" ");
    final cleanLocation = splitLocation.sublist(1).join(" ");

    final idProvince = newAddressController.listProvince
        .firstWhere((province) => province!.name.contains(geoProvince))
        ?.id;

    await newAddressController.getCityData(idProvince!, needLoading: false);

    final city = newAddressController.listCity
        .where((city) =>
            city!.name.contains(cleanLocation) && city.idProvince == idProvince)
        .map((e) => {
              'id': e!.idCity,
              'name': e.name,
              'type': e.type,
            })
        .toList();

    newAddressController.getPostalCodeData(city[0]['id']!);

    newAddressController.currentSelectedAddress['selectedAddress'] = {
      'province': geoProvince,
      'idProvince': idProvince,
      'city': '${shortenKabupaten(city[0]['type']!)} ${city[0]['name']!}',
      'idCity': city[0]['id']!,
      'postalCode': '',
    };

    newAddressController.nowCurrentSelectedAddress.value = 'postalCode';
    newAddressController.provinceIsSet.value = true;
    newAddressController.cityIsSet.value = true;

    isLoadingMap.value = false;
    newAddressController.isAddressSetManual.value = true;
  }

  Future<void> getCurrentLocation() async {
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

    _currentPosition = LatLng(position.latitude, position.longitude);
    // Tandai bahwa peta siap untuk di-update

    // Setelah lokasi didapatkan, arahkan peta ke lokasi tersebut
    await getAddressFromLatLng(
        _currentPosition.latitude, _currentPosition.longitude);
  }

  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      // Melakukan reverse geocoding
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      // Menampilkan hasil alamat
      address.value = [
        GeolocationAddress(
          nameProvince: place.administrativeArea ?? '',
          nameCity: place.subAdministrativeArea ?? '',
        )
      ];
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}
