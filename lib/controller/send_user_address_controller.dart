import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/map_geolocation_controller.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';

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
