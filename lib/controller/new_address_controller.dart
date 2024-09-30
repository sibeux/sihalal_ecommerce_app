import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/models/address_model/city.dart';
import 'package:sihalal_ecommerce_app/models/address_model/postal_code.dart';
import 'package:sihalal_ecommerce_app/models/address_model/province.dart';

class NewAddressController extends GetxController {
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

  var formData = RxMap(
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

  var selectedAddress = RxMap(
    {
      'selectedAddress': {
        'province': '',
        'city': '',
        'postalCode': '',
      },
    },
  );

  void onChanged(String value, String type) {
    final currentController = formData[type]?['controller'];
    // Memperbarui referensi map
    formData[type] = {
      'text': value,
      'type': type,
      'controller': currentController!,
    };
    update();
  }

  void onTap(String type, bool isFocus) {
    final currentController = formData[type]?['controller'];
    final currentText = formData[type]?['text'];
    formData[type] = {
      'text': currentText!,
      'type': type,
      'controller': currentController!,
    };
    currentType.value = isFocus ? type : '';
    update();
  }

  void onClearController(String type) {
    final currentController =
        formData[type]?['controller'] as TextEditingController;
    currentController.clear();
    formData[type] = {
      'text': '',
      'type': type,
      'controller': currentController,
    };
    update();
  }

  bool getIsNameValid() {
    final nameValue = formData['receiptName']!['text'].toString();
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  bool getIsNameEmpty() {
    final nameValue = formData['receiptName']!['text'].toString();
    return nameValue.isEmpty;
  }

  bool getIsPhoneValid() {
    final phoneValue = formData['receiptPhone']!['text'].toString();
    final phoneRegExp = RegExp(r'^(?:0)8[1-9][0-9]{6,15}$');

    return phoneRegExp.hasMatch(phoneValue) && phoneValue.isNotEmpty;
  }

  bool getIsPhoneEmpty() {
    final phoneValue = formData['receiptPhone']!['text'].toString();
    return phoneValue.isEmpty;
  }

  void togglePrimaryAddress(String type) {
    labelAddress.value = type;
    update();
  }

  bool getIsAllDataValid() {
    return getIsNameValid() && getIsPhoneValid();
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
    selectedAddress['selectedAddress'] = {
      'province': '',
      'city': '',
      'district': '',
    };
    isAddressSetManual.value = false;
    firstLetterLocation.value = '';
    nowCurrentSelectedAddress.value = 'province';
    provinceIsSet.value = false;
    cityIsSet.value = false;
    postalCodeIsSet.value = false;
    update();
  }

  void setFormReceiptDistrictValue(String value) {
    final currentController = formData['receiptDistrict']?['controller'];
    (currentController as TextEditingController).text = value;
    formData['receiptDistrict'] = {
      'text': value,
      'type': 'receiptDistrict',
      'controller': currentController,
    };
    update();
  }

  void setAddressLocation(String location, String area) {
    final currentProvince = selectedAddress['selectedAddress']?['province'];
    final currentCity = selectedAddress['selectedAddress']?['city'];

    switch (area) {
      case 'province':
        selectedAddress['selectedAddress'] = {
          'province': location,
          'city': '',
          'postalCode': '',
        };
        nowCurrentSelectedAddress.value = 'city';
        provinceIsSet.value = true;
        break;
      case 'city':
        selectedAddress['selectedAddress'] = {
          'province': currentProvince ?? '',
          'city': location,
          'postalCode': '',
        };
        nowCurrentSelectedAddress.value = 'postalCode';
        cityIsSet.value = true;
        break;
      case 'postalCode':
        selectedAddress['selectedAddress'] = {
          'province': currentProvince ?? '',
          'city': currentCity ?? '',
          'postalCode': location,
        };
        nowCurrentSelectedAddress.value = 'done';
        postalCodeIsSet.value = true;
        isAllLocationSet.value = true;
        setFormReceiptDistrictValue(
          '${selectedAddress['selectedAddress']?['province']}\n'
          '${selectedAddress['selectedAddress']?['city']}\n'
          '${selectedAddress['selectedAddress']?['postalCode']}',
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

  Future<void> getCityData(String id) async {
    isGetLocationLoading.value = true;
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
    isGetLocationLoading.value = false;
  }
}
