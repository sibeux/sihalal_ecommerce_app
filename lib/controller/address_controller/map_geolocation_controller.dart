import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/address_controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/models/address_model/geolocation_address.dart';

import 'package:http/http.dart' as http;

class MapGeolocationController extends GetxController {
  LatLng currentPosition = const LatLng(-6.200000, 106.816666);
  var address = RxList<GeolocationAddress?>([]);
  var isLoadingMap = false.obs;

  // pin point map screen
  GoogleMapController? mapController;
  var centerPosition = Rx<LatLng>(const LatLng(-6.200000, 106.816666));
  var selectedLocation = Rx<LatLng?>(null);

  final NewAddressController newAddressController =
      Get.find<NewAddressController>();

  void getPosition() async {
    await getCurrentLocation();
    if (address.isNotEmpty) {
      final geoProvince = address[0]!.nameProvince;
      final geoCity = address[0]!.nameCity;

      final splitLocation = geoCity.split(" ");
      final cleanLocation = splitLocation.sublist(1).join(" ");

      final idProvince = newAddressController.listProvince
          .firstWhere((province) => province!.name.contains(geoProvince))
          ?.id;

      await newAddressController.getCityData(idProvince!, needLoading: false);

      final city = newAddressController.listCity
          .where(
            (city) =>
                city!.name.contains(cleanLocation) &&
                city.idProvince == idProvince,
          )
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

      newAddressController.isAddressSetManual.value = true;
    }
    isLoadingMap.value = false;
  }

  Future<void> getCurrentLatLng({required bool needFetchMap}) async {
    if (needFetchMap) {
      await getCurrentLocation();
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {});
    }
    isLoadingMap.value = false;
  }

  Future<void> getCurrentLocation() async {
    isLoadingMap.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    // Cek apakah layanan lokasi tersedia
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Jika tidak aktif, minta pengguna untuk mengaktifkan lokasi
      await Geolocator.openLocationSettings();
      isLoadingMap.value = false;
      return;
    }

    // Cek izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Jika izin ditolak, tidak bisa lanjut
        isLoadingMap.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Jika pengguna memblokir izin lokasi secara permanen
      isLoadingMap.value = false;
      return;
    }

    // Jika izin diberikan, dapatkan lokasi saat ini
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = LatLng(position.latitude, position.longitude);
    // Tandai bahwa peta siap untuk di-update

    // Setelah lokasi didapatkan, arahkan peta ke lokasi tersebut
    await getAddressFromLatLngByGeocoding(
        currentPosition.latitude, currentPosition.longitude);

    // await getAddressFromLatLngByGoogleMapApi(
    //     currentPosition.latitude, currentPosition.longitude);
  }

  Future<void> getAddressFromLatLngByGeocoding(
      double latitude, double longitude) async {
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

  Future<void> getAddressFromLatLngByGoogleMapApi(
      double latitude, double longitude) async {
    const String apiKey = 'AIzaSyDyz0mjJ1Y5TYQmVSEahOPHw1NvTb1uERA';

    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=id&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      String kabupaten = '';
      String provinsi = '';

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['results'][0].isNotEmpty) {
          for (var component in data['results'][0]['address_components']) {
            if (component['types'].contains('administrative_area_level_2')) {
              kabupaten = component['long_name'];
            }

            if (component['types'].contains('administrative_area_level_1')) {
              provinsi = component['long_name'];
            }
          }

          // Menampilkan hasil alamat
          address.value = [
            GeolocationAddress(
              nameProvince: provinsi,
              nameCity: kabupaten,
            )
          ];
        } else {
          if (kDebugMode) {
            print('Tidak ada hasil');
          }
        }
      } else {
        if (kDebugMode) {
          print('Gagal mendapatkan alamat');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }
}
