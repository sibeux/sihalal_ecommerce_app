import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html_unescape/html_unescape.dart';

import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/component/regex_drive.dart';
import 'package:sihalal_ecommerce_app/models/user.dart';

class UserProfileController extends GetxController {
  var userData = RxList<User>([]);
  var isLoading = false.obs;
  var unescape = HtmlUnescape();
  var idUser = '';

  @override
  void onInit() async {
    super.onInit();
    await getUserData();
  }

  Future<void> getUserData() async {
    isLoading.value = true;
    final box = GetStorage();
    final email = box.read('email');

    final String url =
        'https://sibeux.my.id/project/sihalal/user?method=get_user_data&email=$email';
    const api =
        'https://sibeux.my.id/cloud-music-player/database/mobile-music-player/api/gdrive_api.php';

    try {
      final response = await http.get(Uri.parse(url));
      final apiResponse = await http.get(Uri.parse(api));

      final List<dynamic> listData = json.decode(response.body);
      final List<dynamic> apiData = json.decode(apiResponse.body);

      if (listData.isNotEmpty) {
        final list = listData.map((user) {
          return User(
            idUser: user['id_user'],
            emailuser: user['email_user'],
            passUser: user['pass_user'],
            nameUser: user['nama_user'],
            nameShop: user['nama_toko'] == null
                ? ''
                : unescape.convert(user['nama_toko']),
            descShop: user['deskripsi_toko'] == null
                ? ''
                : unescape.convert(user['deskripsi_toko']),
            fotoUser: user['foto_user'] == null
                ? ''
                : regexGdriveLink(user['foto_user'], apiData[0]['gdrive_api']),
          );
        }).toList();

        idUser = list[0].idUser;

        userData.value = list;
      } else {
        userData.value = [];
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
