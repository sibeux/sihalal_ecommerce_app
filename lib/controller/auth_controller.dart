import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sihalal_ecommerce_app/controller/jwt_controller.dart';
import 'package:sihalal_ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:sihalal_ecommerce_app/screens/user_auth_screen/register_data_screen.dart';

class AuthFormController extends GetxController {
  var isObscure = true.obs;
  var currentType = ''.obs;
  var formData = RxMap(
    {
      'emailLogin': {
        'text': '',
        'type': 'emailLogin',
        'controller': TextEditingController(),
      },
      'passwordLogin': {
        'text': '',
        'type': 'passwordLogin',
        'controller': TextEditingController(),
      },
      'emailRegister': {
        'text': '',
        'type': 'emailRegister',
        'controller': TextEditingController(),
      },
      'nameRegister': {
        'text': '',
        'type': 'nameRegister',
        'controller': TextEditingController(),
      },
      'passwordRegister': {
        'text': '',
        'type': 'passwordRegister',
        'controller': TextEditingController(),
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

  void toggleObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  bool getIsEmailValid(String type) {
    final emailValue = formData[type]!['text'].toString();
    return EmailValidator.validate(emailValue);
  }

  bool getIsDataLoginValid() {
    final emailValue = formData['emailLogin']!['text'].toString();
    return EmailValidator.validate(emailValue) &&
        emailValue.isNotEmpty &&
        formData['passwordLogin']!['text'].toString().isNotEmpty;
  }

  bool getIsDataRegisterValid() {
    return formData['nameRegister']!['text'].toString().isNotEmpty &&
        formData['passwordRegister']!['text'].toString().isNotEmpty;
  }

  bool getIsNameValid() {
    final nameValue = formData['nameRegister']!['text'].toString();
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

    return !nameRegExp.hasMatch(nameValue) && nameValue.isNotEmpty;
  }

  get isObscureValue => isObscure.value;
}

class UserRegisterController extends GetxController {
  var isLoading = false.obs;
  var isEmailRegistered = false.obs;
  var isRedirecting = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
    isEmailRegistered.value = false;
    isRedirecting.value = false;
  }

  Future<void> getCheckEmail({required String email}) async {
    isLoading.value = true;

    const String url = 'https://sibeux.my.id/project/sihalal/auth';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'email_check',
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        bool emailExists = jsonResponse['email_exists'] == 'true';

        if (emailExists) {
          isEmailRegistered.value = true;
        } else {
          isEmailRegistered.value = false;
          Get.to(
            () => const RegisterDataScreen(),
            transition: Transition.rightToLeftWithFade,
          );
        }
      } else {
        if (kDebugMode) {
          print('Failed checking. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNewUserData({
    required String email,
    required String name,
    required String password,
  }) async {
    isLoading.value = true;

    const String url = 'https://sibeux.my.id/project/sihalal/auth';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'method': 'create_user',
          'email': email,
          'name': name,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        bool success = jsonResponse['status'] == 'success';

        if (success) {
          isLoading.value = false;
          await generateJwtRegister(email: email, password: password);
        } else {
          if (kDebugMode) {
            print('Failed registering. Error: ${response.statusCode}');
          }
        }
      } else {
        if (kDebugMode) {
          print('Failed registering. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> generateJwtRegister(
      {required String email, required String password}) async {
    const String url = 'https://sibeux.my.id/project/sihalal-php-jwt/login';
    final jwtController = Get.put(JwtController());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        isRedirecting.value = true;
        final jsonResponse = jsonDecode(response.body);
        await jwtController.setToken(
          token: jsonResponse['token'],
          email: email,
        );
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        if (kDebugMode) {
          print('Failed generating JWT. Error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    } finally {
      isLoading.value = false;
      isRedirecting.value = false;
    }
  }
}

class UserLoginController extends GetxController {
  var isLoading = false.obs;
  var isLoginSuccess = true.obs;
  var isRedirecting = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
    isLoginSuccess.value = true;
    isRedirecting.value = false;
  }

  Future<void> generateJwtLogin(
      {required String email, required String password}) async {
    isLoading.value = true;

    final jwtController = Get.put(JwtController());
    const String url = 'https://sibeux.my.id/project/sihalal-php-jwt/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        isLoginSuccess.value = true;
        isLoading.value = false;
        isRedirecting.value = true;
        final jsonResponse = jsonDecode(response.body);
        await jwtController.setToken(
          token: jsonResponse['token'],
          email: email,
        );
        Get.offAll(
          () => const HomeScreen(),
          transition: Transition.rightToLeftWithFade,
        );
      } else {
        isLoginSuccess.value = false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
      }
    } finally {
      isLoading.value = false;
      isRedirecting.value = false;
    }
  }
}
