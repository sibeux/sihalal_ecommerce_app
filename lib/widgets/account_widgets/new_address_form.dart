import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/receipt_district_screen.dart';

class ReceiptName extends StatelessWidget {
  const ReceiptName({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'receiptName',
      keyboardType: TextInputType.text,
      icon: Icons.person,
      formText: 'Nama Penerima',
      autoFillHints: AutofillHints.name,
      maxLength: 30,
    );
  }
}

class ReceiptPhone extends StatelessWidget {
  const ReceiptPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return const FormBlueprint(
      formType: 'receiptPhone',
      keyboardType: TextInputType.phone,
      icon: Icons.phone,
      formText: 'Nomor Telepon Penerima',
      autoFillHints: AutofillHints.telephoneNumber,
      maxLength: 15,
    );
  }
}

class ReceiptDistrict extends StatelessWidget {
  const ReceiptDistrict({super.key});

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.put(NewAddressController());
    final controller =
        newAddressController.formData['receiptDistrict']?['controller'];
    return GestureDetector(
      onTap: () {
        if ((controller as TextEditingController).text.isEmpty) {
          newAddressController.getProvinceData();
        } else {
          final currentProvince = newAddressController
              .alreadySelectedAddress['selectedAddress']!['province'];
          final currentCity = newAddressController
              .alreadySelectedAddress['selectedAddress']!['city'];
          final currentCode = newAddressController
              .alreadySelectedAddress['selectedAddress']!['postalCode'];

          newAddressController.provinceIsSet.value = true;
          newAddressController.cityIsSet.value = true;
          newAddressController.postalCodeIsSet.value = true;

          newAddressController.currentSelectedAddress['selectedAddress'] = {
            'province': currentProvince ?? '',
            'city': currentCity ?? '',
            'postalCode': currentCode ?? '',
          };

          newAddressController.isAddressSetManual.value = true;
          newAddressController.listCurrentLocation.value =
              newAddressController.alreadyListPostalCode;
        }
        Get.to(
          () => const ReceiptDistrictScreen(),
          transition: Transition.rightToLeft,
          fullscreenDialog: true,
          popGesture: false,
        );
      },
      child: const AbsorbPointer(
        child: FormBlueprint(
          formType: 'receiptDistrict',
          keyboardType: TextInputType.text,
          icon: Icons.location_city,
          formText: 'Provinsi, Kota, Kode Pos',
          autoFillHints: '',
          maxLength: 300,
        ),
      ),
    );
  }
}

class ReceiptStreet extends StatelessWidget {
  const ReceiptStreet({super.key});

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.put(NewAddressController());
    final controller = newAddressController.formData['receiptDistrict']
        ?['controller'] as TextEditingController;

    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, TextEditingValue value, child) {
        return GestureDetector(
          onTap: () {
            if (controller.text.isEmpty) {
              Fluttertoast.showToast(
                msg: 'Mohon pilih provinsi, kota, dan kode pos terlebih dahulu',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black.withOpacity(0.8),
                textColor: Colors.white,
                fontSize: 10.0,
              );
            }
          },
          child: AbsorbPointer(
            absorbing: value.text.isEmpty,
            child: const FormBlueprint(
              formType: 'receiptStreet',
              keyboardType: TextInputType.text,
              icon: Icons.location_on,
              formText: 'Nama Jalan, Nomor Rumah',
              autoFillHints: AutofillHints.streetAddressLine1,
              maxLength: 300,
            ),
          ),
        );
      },
    );
  }
}

class FormBlueprint extends StatelessWidget {
  const FormBlueprint({
    super.key,
    required this.formType,
    required this.keyboardType,
    required this.icon,
    required this.formText,
    required this.autoFillHints,
    required this.maxLength,
  });

  final String formType, formText, autoFillHints;
  final TextInputType keyboardType;
  final IconData icon;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    final NewAddressController newAddressController =
        Get.put(NewAddressController());
    final controller = newAddressController.formData[formType]?['controller'];
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          controller: controller as TextEditingController?,
          cursorColor: HexColor('#575757'),
          textAlignVertical: TextAlignVertical.center,
          enableSuggestions: true,
          autofillHints: [autoFillHints],
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: formType == 'receiptDistrict'
              ? (controller as TextEditingController).text.isNotEmpty
                  ? 3
                  : 1
              : 1,
          onChanged: (value) {
            newAddressController.onChanged(value, formType);
          },
          onTap: () {
            newAddressController.onTap(formType, true);
          },
          onTapOutside: (event) {
            newAddressController.onTap(formType, false);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
          buildCounter: (context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return null; // Menghilangkan teks maxLength
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: HexColor('#575757'),
            ),
            suffixIcon: formType == 'receiptDistrict'
                ? Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: HexColor('#575757'),
                  )
                : null,
            filled: true,
            isDense: true,
            fillColor: HexColor('#fefffe'),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 12,
            ),
            hintText: formText.capitalize,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 45,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 45,
            ),
            enabledBorder: outlineInputBorder(newAddressController, formType),
            focusedBorder: outlineInputBorder(newAddressController, formType),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder(
    NewAddressController newAddressController, String formType) {
  final textValue = newAddressController.formData[formType]?['text'].toString();
  final isCurrentType = newAddressController.currentType.value == formType;

  return OutlineInputBorder(
    borderSide: BorderSide(
      color: (isCurrentType || textValue!.isNotEmpty)
          ? formType.toLowerCase().contains('name')
              ? !newAddressController.getIsNameValid() && textValue!.isNotEmpty
                  ? HexColor('#ff0000').withOpacity(0.5)
                  : ColorPalette().primary.withOpacity(0.5)
              : formType.toLowerCase().contains('phone')
                  ? !newAddressController.getIsPhoneValid() &&
                          textValue!.isNotEmpty
                      ? HexColor('#ff0000').withOpacity(0.5)
                      : ColorPalette().primary.withOpacity(0.5)
                  : ColorPalette().primary.withOpacity(0.5)
          : HexColor('#575757').withOpacity(0.5),
      width: 2,
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(7),
    ),
  );
}
