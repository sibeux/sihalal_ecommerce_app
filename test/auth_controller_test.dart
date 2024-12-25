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
}
