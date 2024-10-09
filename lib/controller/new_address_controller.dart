import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/map_geolocation_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/address_model/city.dart';
import 'package:sihalal_ecommerce_app/models/address_model/postal_code.dart';
import 'package:sihalal_ecommerce_app/models/address_model/province.dart';

class NewAddressController extends GetxController {
  final userAddressController = Get.find<UserAddressController>();

  var currentType = ''.obs;
  var isPrimaryAddress = false.obs;
  var isStoreAddress = false.obs;
  var labelAddress = 'primary'.obs;
  var firstLetterLocation = ''.obs;
  var isGetLocationLoading = false.obs;
  var isAddressSetManual = false.obs;
  var needRebuildTrack = false.obs;
  var nowCurrentSelectedAddress = 'province'.obs;
  var isAllLocationSet = false.obs;

  var provinceIsSet = false.obs;
  var cityIsSet = false.obs;
  var postalCodeIsSet = false.obs;

  var listCurrentLocation = RxList([]);
  var listProvince = RxList<Province?>([]);
  var listCity = RxList<City?>([]);

  var currentListPostalCode = RxList<PostalCode?>([]);
  var alreadyListPostalCode = RxList<PostalCode?>([]);

  var isLoadingSetEditAddress = false.obs;
  var isEditAddress = false.obs;
  var isSetPrimary = false.obs;
  var isSetStore = false.obs;

  var newAddressFormData = RxMap(
    {
      'receiptName': {
        'text': '',
        'type': 'receiptName',
        'controller': TextEditingController(),
      },
      'receiptPhone': {
        'text': '',
        'type': 'receiptPhone',
        'controller': TextEditingController(),
      },
      'receiptDistrict': {
        'text': '',
        'type': 'receiptDistrict',
        'controller': TextEditingController(),
      },
      'receiptStreet': {
        'text': '',
        'type': 'receiptStreet',
        'controller': TextEditingController(),
      },
    },
  );

  var currentSelectedAddress = RxMap(
    {
      'selectedAddress': {
        'province': '',
        'idProvince': '',
        'city': '',
        'idCity': '',
        'postalCode': '',
      },
    },
  );

  var alreadySelectedAddress = RxMap(
    {
      'selectedAddress': {
        'province': '',
        'idProvince': '',
        'city': '',
        'idCity': '',
        'postalCode': '',
      },
    },
  );

  @override
  void onInit() async {
    isPrimaryAddress.value = !userAddressController.isSetPrimary.value;
    isStoreAddress.value = !userAddressController.isSetStore.value;
    super.onInit();
  }

  void onChanged(String value, String type) {
    final currentController = newAddressFormData[type]?['controller'];
    // Memperbarui referensi map
    newAddressFormData[type] = {
      'text': value,
      'type': type,
      'controller': currentController!,
    };
    update();
  }

  void onTap(String type, bool isFocus) {
    final currentController = newAddressFormData[type]?['controller'];
    final currentText = newAddressFormData[type]?['text'];
    newAddressFormData[type] = {
      'text': currentText!,
      'type': type,
      'controller': currentController!,
    };
    currentType.value = isFocus ? type : '';
    update();
  }

  void onClearController(String type) {
    final currentController =
        newAddressFormData[type]?['controller'] as TextEditingController;
    currentController.clear();
    newAddressFormData[type] = {
      'text': '',
      'type': type,
      'controller': currentController,
    };
    update();
  }

  bool getIsNameValid() {
    final nameValue = newAddressFormData['receiptName']!['text'].toString();
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  bool getIsNameEmpty() {
    final nameValue = newAddressFormData['receiptName']!['text'].toString();
    return nameValue.isEmpty;
  }

  bool getIsPhoneValid() {
    final phoneValue = newAddressFormData['receiptPhone']!['text'].toString();
    final phoneRegExp = RegExp(r'^(?:0)8[1-9][0-9]{6,15}$');

    return phoneRegExp.hasMatch(phoneValue) && phoneValue.isNotEmpty;
  }

  bool getIsPhoneEmpty() {
    final phoneValue = newAddressFormData['receiptPhone']!['text'].toString();
    return phoneValue.isEmpty;
  }

  void togglePrimaryAddress(String type) {
    labelAddress.value = type;
    update();
  }

  bool getIsAllDataValid() {
    final receiptDistrictController = newAddressFormData['receiptDistrict']
        ?['controller'] as TextEditingController;

    final receiptStreetController = newAddressFormData['receiptStreet']
        ?['controller'] as TextEditingController;

    return getIsNameValid() &&
        getIsPhoneValid() &&
        receiptDistrictController.text.isNotEmpty &&
        receiptStreetController.text.isNotEmpty;
  }

  bool isCanSetPin() {
    final receiptDistrictController = newAddressFormData['receiptDistrict']
        ?['controller'] as TextEditingController;

    final receiptStreetController = newAddressFormData['receiptStreet']
        ?['controller'] as TextEditingController;

    return receiptDistrictController.text.isNotEmpty &&
        receiptStreetController.text.isNotEmpty;
  }

  bool getFirstLetterLocation(String location) {
    if (firstLetterLocation.value != location.substring(0, 1).toUpperCase()) {
      firstLetterLocation.value = location.substring(0, 1).toUpperCase();
      return true;
    } else {
      return false;
    }
  }

  bool isIncreaseHeightTrack(String location) {
    switch (location) {
      case 'province':
        return cityIsSet.value;
      case 'city':
        return postalCodeIsSet.value;
      case 'postalCode':
        return true;
      default:
        return false;
    }
  }

  void clearSelectedAddress() {
    currentSelectedAddress['selectedAddress'] = {
      'province': '',
      'idProvince': '',
      'city': '',
      'idCity': '',
      'district': '',
    };
    isAddressSetManual.value = false;
    firstLetterLocation.value = '';
    nowCurrentSelectedAddress.value = 'province';
    provinceIsSet.value = false;
    cityIsSet.value = false;
    update();
  }

  void setFormReceiptDistrictValue(String value) {
    final currentController =
        newAddressFormData['receiptDistrict']?['controller'];
    (currentController as TextEditingController).text = value;
    newAddressFormData['receiptDistrict'] = {
      'text': value,
      'type': 'receiptDistrict',
      'controller': currentController,
    };
    alreadyListPostalCode.value = List<PostalCode?>.from(currentListPostalCode);
    update();
  }

  void setAddressLocation(String location, String area) {
    final currentProvince =
        currentSelectedAddress['selectedAddress']?['province'];
    final currentIdProvince =
        currentSelectedAddress['selectedAddress']?['idProvince'];
    final currentCity = currentSelectedAddress['selectedAddress']?['city'];
    final currentIdCity = currentSelectedAddress['selectedAddress']?['idCity'];

    switch (area) {
      case 'province':
        final idProvince = listProvince
                .firstWhere((province) => province!.name == location)
                ?.id ??
            '';
        currentSelectedAddress['selectedAddress'] = {
          'province': location,
          'idProvince': idProvince,
          'city': '',
          'idCity': '',
          'postalCode': '',
        };
        nowCurrentSelectedAddress.value = 'city';
        provinceIsSet.value = true;
        cityIsSet.value = false;
        break;
      case 'city':
        final splitLocation = location.split(" ");
        final cleanLocation = splitLocation.sublist(1).join(" ");
        final idCity = listCity
                .firstWhere(
                  (city) =>
                      city!.name == cleanLocation &&
                      city.idProvince == currentIdProvince,
                  orElse: () => null,
                )
                ?.idCity ??
            '';
        currentSelectedAddress['selectedAddress'] = {
          'province': currentProvince ?? '',
          'idProvince': currentIdProvince ?? '',
          'city': location,
          'idCity': idCity,
          'postalCode': '',
        };
        nowCurrentSelectedAddress.value = 'postalCode';
        cityIsSet.value = true;
        break;
      case 'postalCode':
        currentSelectedAddress['selectedAddress'] = {
          'province': currentProvince ?? '',
          'idProvince': currentIdProvince ?? '',
          'city': currentCity ?? '',
          'idCity': currentIdCity ?? '',
          'postalCode': location,
        };
        alreadySelectedAddress['selectedAddress'] = {
          'province': currentProvince ?? '',
          'idProvince': currentIdProvince ?? '',
          'city': currentCity ?? '',
          'idCity': currentIdCity ?? '',
          'postalCode': location,
        };
        nowCurrentSelectedAddress.value = 'done';
        postalCodeIsSet.value = true;
        isAllLocationSet.value = true;
        setFormReceiptDistrictValue(
          '${currentSelectedAddress['selectedAddress']?['province']}\n'
          '${currentSelectedAddress['selectedAddress']?['city']}\n'
          '${currentSelectedAddress['selectedAddress']?['postalCode']}',
        );
        Get.back();
        break;
    }
    update();
  }

  Future<void> getProvinceData() async {
    isGetLocationLoading.value = true;
    firstLetterLocation.value = '';

    const String url = "https://api.rajaongkir.com/starter/province";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'key': '32a856dfad4b5dbceb3a2da5c8622d9e',
        },
      );

      final listData = json.decode(response.body);

      final List<Province> list =
          listData['rajaongkir']['results'].map<Province>((province) {
        return Province(
          id: province['province_id'],
          name: province['province'],
          area: 'province',
          isFistLetter: getFirstLetterLocation(province['province']),
        );
      }).toList();

      listCurrentLocation.value = list;
      listProvince.value = list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isGetLocationLoading.value = false;
    }
  }

  Future<void> getCityData(String id, {required bool needLoading}) async {
    if (needLoading) {
      isGetLocationLoading.value = true;
    }
    firstLetterLocation.value = '';

    final String url = "https://api.rajaongkir.com/starter/city?province=$id";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'key': '32a856dfad4b5dbceb3a2da5c8622d9e',
        },
      );

      final listData = json.decode(response.body);

      final List<City> list =
          listData['rajaongkir']['results'].map<City>((city) {
        return City(
          idCity: city['city_id'],
          name: city['city_name'],
          area: 'city',
          type: city['type'],
          idProvince: city['province_id'],
          province: city['province'],
          postalCode: city['postal_code'],
          isFistLetter: getFirstLetterLocation(city['city_name']),
        );
      }).toList();

      listCurrentLocation.value = list;
      listCity.value = list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isGetLocationLoading.value = false;
    }
  }

  void getPostalCodeData(String idCity) {
    isGetLocationLoading.value = true;
    firstLetterLocation.value = '';

    final list = listCity.where((city) => city!.idCity == idCity).toList();

    final postalCode = list
        .map(
          (code) => PostalCode(
            postalCode: code!.postalCode,
            area: 'postalCode',
            isFistLetter: false,
          ),
        )
        .toList();

    listCurrentLocation.value = postalCode;
    currentListPostalCode.value = postalCode;
    isGetLocationLoading.value = false;
  }

  Future<void> setDataEditAddress(int index) async {
    final mapGeolocationController = Get.find<MapGeolocationController>();

    isLoadingSetEditAddress.value = true;
    isEditAddress.value = true;

    final name = userAddressController.addressList[index]!.name;
    final province = userAddressController.addressList[index]!.province;
    final idProvince = userAddressController.addressList[index]!.idProvince;
    final city = userAddressController.addressList[index]!.city;
    final idCity = userAddressController.addressList[index]!.idCity;
    final postalCode = userAddressController.addressList[index]!.postalCode;

    isPrimaryAddress.value =
        userAddressController.addressList[index]!.isPrimary;
    isStoreAddress.value = userAddressController.addressList[index]!.isOffice;
    labelAddress.value = userAddressController.addressList[index]!.label;

    isSetPrimary.value = isPrimaryAddress.value;
    isSetStore.value = isStoreAddress.value;

    // Get the string representation of LatLng
    String pinPoint = userAddressController.addressList[index]!.pinPoint;

    // Remove the 'LatLng(' and ')' part from the string and split the coordinates
    pinPoint = pinPoint.replaceAll('LatLng(', '').replaceAll(')', '');
    List<String> latLngValues = pinPoint.split(',');

    // Convert the split values into double and create a LatLng object
    double latitude = double.parse(latLngValues[0].trim());
    double longitude = double.parse(latLngValues[1].trim());

    mapGeolocationController.selectedLocation.value =
        LatLng(latitude, longitude);
    mapGeolocationController.centerPosition.value = LatLng(latitude, longitude);

    newAddressFormData['receiptName'] = {
      'text': name,
      'type': 'receiptName',
      'controller': TextEditingController(text: name),
    };

    newAddressFormData['receiptPhone'] = {
      'text': userAddressController.addressList[index]!.phone,
      'type': 'receiptPhone',
      'controller': TextEditingController(
        text: userAddressController.addressList[index]!.phone,
      ),
    };

    newAddressFormData['receiptDistrict'] = {
      'text': userAddressController.addressList[index]!.detailAddress,
      'type': 'receiptDistrict',
      'controller': TextEditingController(
        text: userAddressController.addressList[index]!.detailAddress,
      ),
    };

    newAddressFormData['receiptStreet'] = {
      'text': userAddressController.addressList[index]!.streetAddress,
      'type': 'receiptStreet',
      'controller': TextEditingController(
        text: userAddressController.addressList[index]!.streetAddress,
      ),
    };

    currentSelectedAddress['selectedAddress'] = {
      'province': province,
      'idProvince': idProvince,
      'city': city,
      'idCity': idCity,
      'postalCode': postalCode,
    };
    alreadySelectedAddress['selectedAddress'] = {
      'province': province,
      'idProvince': idProvince,
      'city': city,
      'idCity': idCity,
      'postalCode': postalCode,
    };
    nowCurrentSelectedAddress.value = 'done';
    provinceIsSet.value = true;
    cityIsSet.value = true;
    postalCodeIsSet.value = true;
    isAllLocationSet.value = true;
    setFormReceiptDistrictValue(
      '${currentSelectedAddress['selectedAddress']?['province']}\n'
      '${currentSelectedAddress['selectedAddress']?['city']}\n'
      '${currentSelectedAddress['selectedAddress']?['postalCode']}',
    );

    isLoadingSetEditAddress.value = false;
  }
}

class SendUserAddressController extends GetxController {
  var isLoadingSendAddress = false.obs;

  final userProfileController = Get.find<UserProfileController>();
  final newAddressController = Get.find<NewAddressController>();
  final mapGeolocationController = Get.find<MapGeolocationController>();
  final userAddressController = Get.find<UserAddressController>();

  var selecteduserAddress = RxMap(
    {
      'userAddress': {
        'id_user': '',
        'receipt_name': '',
        'receipt_phone': '',
        'label_address': '',
        'province': '',
        'id_province': '',
        'city': '',
        'id_city': '',
        'postal_code': '',
        'detail_address': '',
        'street_address': '',
        'pin_point': '',
        'is_primary_address': false,
        'is_store_address': false,
      },
    },
  );

  Future<void> sendAddress(bool isNewAddress, int index) async {
    isLoadingSendAddress.value = true;

    selecteduserAddress['userAddress'] = {
      'id_user': userProfileController.userData[0].idUser,
      'receipt_name': newAddressController
          .newAddressFormData['receiptName']!['text'] as String,
      'receipt_phone': newAddressController
          .newAddressFormData['receiptPhone']!['text'] as String,
      'label_address': newAddressController.labelAddress.value,
      'province': newAddressController.alreadySelectedAddress['selectedAddress']
              ?['province'] ??
          '',
      'id_province': newAddressController
              .alreadySelectedAddress['selectedAddress']?['idProvince'] ??
          '',
      'city': newAddressController.alreadySelectedAddress['selectedAddress']
              ?['city'] ??
          '',
      'id_city': newAddressController.alreadySelectedAddress['selectedAddress']
              ?['idCity'] ??
          '',
      'postal_code': newAddressController
              .alreadySelectedAddress['selectedAddress']?['postalCode'] ??
          '',
      'detail_address': newAddressController
          .newAddressFormData['receiptDistrict']!['text'] as String,
      'street_address': newAddressController
          .newAddressFormData['receiptStreet']!['text'] as String,
      'pin_point': mapGeolocationController.selectedLocation.value.toString(),
      'is_primary_address':
          newAddressController.isPrimaryAddress.value ? 'true' : 'false',
      'is_store_address':
          newAddressController.isStoreAddress.value ? 'true' : 'false',
    };

    const String uri = "https://sibeux.my.id/project/sihalal/address";

    try {
      Map<String, dynamic> data = {};
      if (isNewAddress) {
        data = {
          'method': 'send_user_address',
          'address': selecteduserAddress['userAddress'],
          'id_primary': userAddressController.alreadySetPrimaryId.value,
          'id_store': userAddressController.alreadySetStoreId.value,
          'reset_primary':
              newAddressController.isPrimaryAddress.value ? 'true' : 'false',
          'reset_store':
              newAddressController.isStoreAddress.value ? 'true' : 'false',
        };
      } else {
        data = {
          'method': 'update_user_address',
          'id_address': userAddressController.addressList[index]!.idAddress,
          'address': selecteduserAddress['userAddress'],
          'id_primary': userAddressController.alreadySetPrimaryId.value,
          'id_store': userAddressController.alreadySetStoreId.value,
          'reset_primary':
              newAddressController.isPrimaryAddress.value ? 'true' : 'false',
          'reset_store':
              newAddressController.isStoreAddress.value ? 'true' : 'false',
        };
      }

      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.back();
        await userAddressController.getUserAddress();
        if (kDebugMode) {
          print('Data berhasil dikirim: ${response.body}');
        }
      } else {
        if (kDebugMode) {
          print('Gagal mengirim data: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoadingSendAddress.value = false;
    }
  }

  Future<void> deleteUserAddress({required String idAddress}) async {
    isLoadingSendAddress.value = true;

    const String uri = "https://sibeux.my.id/project/sihalal/address";

    try {
      final response = await http.post(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'method': 'delete_user_address',
          'id_address': idAddress,
        }),
      );

      if (response.statusCode == 200) {
        Get.back();
        await userAddressController.getUserAddress();
        if (kDebugMode) {
          print('Data berhasil dihapus: ${response.body}');
        }
      } else {
        if (kDebugMode) {
          print('Gagal menghapus data: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      isLoadingSendAddress.value = false;
    }
  }
}
