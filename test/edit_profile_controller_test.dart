import 'package:flutter_test/flutter_test.dart';
import 'package:sihalal_ecommerce_app/controller/edit_profile_controller.dart';

void main() {
  final EditProfileController editProfileController = EditProfileController();
  group('nameValidation', () {
    test('name valid', () {
      editProfileController.name.value = 'Nasrul Wahabi';
      expect(editProfileController.getIsNameNotValid(), !true);
    });

    test('name invalid', () {
      editProfileController.name.value = 'Nasrul Wahabi123';
      expect(editProfileController.getIsNameNotValid(), !false);
    });

    test('name null', () {
      editProfileController.name.value = '';
      expect(editProfileController.getIsNameNotValid(), false);
    });

    test('name whitespace', () {
      editProfileController.name.value = ' ';
      expect(editProfileController.getIsNameNotValid(), false);
    });

    test('name too short', () {
      editProfileController.name.value = 'Na';
      expect(editProfileController.getIsNameNotValid(), !true);
    });
  });
}
