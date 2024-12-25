import 'package:flutter_test/flutter_test.dart';
import 'package:sihalal_ecommerce_app/controller/auth_controller.dart';

void main() {
  final AuthFormController authFormController = AuthFormController();
  group('emailValidation', () {
    test("email valid", () {
      authFormController.onChanged('wahabinasrul@gmail.com', 'emailLogin');
      expect(authFormController.getIsEmailValid('emailLogin'), true);
    });

    test("email invalid", () {
      authFormController.onChanged('wahabinasrul', 'emailLogin');
      expect(authFormController.getIsEmailValid('emailLogin'), false);
    });

    test("email empty", () {
      authFormController.onChanged('', 'emailLogin');
      expect(authFormController.getIsEmailValid('emailLogin'), false);
    });

    test("email whitespace", () {
      authFormController.onChanged(' ', 'emailLogin');
      expect(authFormController.getIsEmailValid('emailLogin'), false);
    });
  });

  group('dataLoginValidation', () {
    test('data login valid', () {
      authFormController.onChanged('wahabinasrul@gmail.com', 'emailLogin');
      authFormController.onChanged('123456', 'passwordLogin');
      expect(authFormController.getIsDataLoginValid(), true);
    });

    test('data login invalid', () {
      authFormController.onChanged('wahabinasrulgmail.com', 'emailLogin');
      authFormController.onChanged('', 'passwordLogin');
      expect(authFormController.getIsDataLoginValid(), false);
    });
  });

  group('dataRegisteredValidation', () {
    test('data registered valid', () {
      authFormController.onChanged('Nasrul Wahabi', 'nameRegister');
      authFormController.onChanged('123123', 'passwordRegister');
      expect(authFormController.getIsDataRegisterValid(), true);
    });

    test('data registered invalid', () {
      authFormController.onChanged('Nasrul Wahabi', 'nameRegister');
      authFormController.onChanged('', 'passwordRegister');
      expect(authFormController.getIsDataRegisterValid(), false);
    });
  });

  group('nameValidation', () {
    test('name valid', () {
      authFormController.onChanged('Nasrul Wahabi', 'nameRegister');
      expect(authFormController.getIsNameValid(), !true);
    });

    test('name invalid', () {
      authFormController.onChanged('Nasrul Wahabi123', 'nameRegister');
      expect(authFormController.getIsNameValid(), !false);
    });

    test('name empty', () {
      authFormController.onChanged('', 'nameRegister');
      expect(authFormController.getIsNameValid(), false);
    });

    test('name whitespace', () {
      authFormController.onChanged(' ', 'nameRegister');
      expect(authFormController.getIsNameValid(), false);
    });
  });
}
