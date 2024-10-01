import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGeolocationController extends GetxController {
  LatLng _currentPosition = const LatLng(-6.200000, 106.816666);
  var address = "".obs;
  var isLoadingMap = false.obs;

  void getPosition() async {
    isLoadingMap.value = true;
    await getCurrentLocation();
    print(address.value);
    isLoadingMap.value = false;
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
      address.value =
          "${place.name}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}
