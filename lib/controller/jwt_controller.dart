import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class JwtController extends GetxController {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<void> setToken({required String token, email}) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'login', value: 'true');
  }

  Future<void> checkToken() async {
    final token = await storage.read(key: 'token');
    if (token != null) {
      sendTokenToServer(token);
    } else {
      await storage.write(key: 'login', value: 'false');
      if (kDebugMode) {
        print('Token not found');
      }
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'email');
    await storage.delete(key: 'login');
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
          setToken(token: token, email: email);
        } else {
          await storage.write(key: 'login', value: 'false');
        }
      } else {
        await storage.write(key: 'login', value: 'false');
        if (kDebugMode) {
          print('Failed sending token. Error: ${response.statusCode}');
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
