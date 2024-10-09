import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/controller/user_profile_controller.dart';
import 'package:sihalal_ecommerce_app/models/address_model/address.dart';
import 'package:http/http.dart' as http;

class UserAddressController extends GetxController {
  var addressList = RxList<Address?>([]);
  var isLoadingGetAddress = false.obs;
  var isSetPrimary = false.obs;
  var isSetStore = false.obs;
  var alreadySetPrimaryId = ''.obs;
  var alreadySetStoreId = ''.obs;

  @override
  void onInit() async {
    await getUserAddress();
    super.onInit();
  }

  Future<void> getUserAddress() async {
    isLoadingGetAddress.value = true;

    final userProfileController = Get.find<UserProfileController>();
    final idUser = userProfileController.userData[0].idUser;

    final String uri =
        'https://sibeux.my.id/project/sihalal/address?method=get_user_address&id_user=$idUser';

    try {
      final response = await http.get(Uri.parse(uri));

      final List<dynamic> listData = json.decode(response.body);

      final list = listData.map((address) {
        if (address['is_utama'] == 'true') {
          isSetPrimary.value = true;
          alreadySetPrimaryId.value = address['id_alamat'];
        }
        if (address['is_toko'] == 'true') {
          isSetStore.value = true;
          alreadySetStoreId.value = address['id_alamat'];
        }

        return Address(
          idAddress: address['id_alamat'],
          idUser: address['id_user'],
          name: address['nama_penerima'],
          phone: address['nomor_penerima'],
          label: address['label_alamat'],
          province: address['provinsi'],
          idProvince: address['id_provinsi'],
          city: address['kota'],
          idCity: address['id_kota'],
          postalCode: address['kode_pos'],
          detailAddress: address['detail_alamat'],
          streetAddress: address['jalan_alamat'],
          pinPoint: address['pinpoint_alamat'],
          isPrimary: address['is_utama'] == 'true',
          isOffice: address['is_toko'] == 'true',
        );
      }).toList();

      addressList.value = list;
    } catch (e) {
      if (kDebugMode) {
        print('Error getUserAddress: $e');
      }
    } finally {
      isLoadingGetAddress.value = false;
    }
  }
}
