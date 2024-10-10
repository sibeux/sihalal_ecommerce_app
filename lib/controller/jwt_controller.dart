import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class JwtController extends GetxController {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  final box = GetStorage();

  Future<void> setToken({required String token, email}) async {
    await storage.write(key: 'token', value: token);
    box.write('login', true);
    box.write('email', email);
  }

  Future<void> checkToken() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      await sendTokenToServer(token);
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    box.write('login', false);
    box.remove('email');
  }

  Future<void> sendTokenToServer(String token) async {
    final url =
        Uri.parse('https://sibeux.my.id/project/sihalal-php-jwt/verify');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if ((jsonResponse['login'] == 'sukses') &&
            (jsonResponse['exp'] == 'no')) {
          final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          final email = decodedToken['data']['email'];
          await setToken(token: token, email: email);
        }
      }
    } catch (e) {
      await storage.write(key: 'login', value: 'false');
      if (kDebugMode) {
        print('Error occurred while sending token: $e');
      }
    }
  }
}
