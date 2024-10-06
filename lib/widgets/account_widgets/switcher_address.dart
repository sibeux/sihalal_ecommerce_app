import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/user_address_controller.dart';

class PrimaryAddressSwitcher extends StatelessWidget {
  const PrimaryAddressSwitcher({
    super.key,
    required this.newAddressController,
  });

  final NewAddressController newAddressController;

  @override
  Widget build(BuildContext context) {
    final userAddressController = Get.find<UserAddressController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'Jadikan Alamat Utama',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.8,
            child: Obx(
              () => Opacity(
                opacity: userAddressController.isSetPrimary.value ? 1 : 0.5,
                child: AbsorbPointer(
                  absorbing: !userAddressController.isSetPrimary.value,
                  child: Switch(
                    value: newAddressController.isPrimaryAddress.value,
                    onChanged: (value) {
                      newAddressController.isPrimaryAddress.value = value;
                    },
                    activeColor: ColorPalette().primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoreAddressSwitcher extends StatelessWidget {
  const StoreAddressSwitcher({
    super.key,
    required this.newAddressController,
  });

  final NewAddressController newAddressController;

  @override
  Widget build(BuildContext context) {
    final userAddressController = Get.find<UserAddressController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            'Jadikan Alamat Toko',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.8,
            child: Obx(
              () => Opacity(
                opacity: userAddressController.isSetStore.value ? 1 : 0.5,
                child: AbsorbPointer(
                  absorbing: !userAddressController.isSetStore.value,
                  child: Switch(
                    value: newAddressController.isStoreAddress.value,
                    onChanged: (value) {
                      newAddressController.isStoreAddress.value = value;
                    },
                    activeColor: ColorPalette().primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LabelAddressSwitcher extends StatelessWidget {
  const LabelAddressSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.find<NewAddressController>();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              'Label Alamat:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    newAddressController.togglePrimaryAddress(
                      'primary',
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          newAddressController.labelAddress.value == 'primary'
                              ? ColorPalette().primary
                              : HexColor('#eff4f8'),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Rumah',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            newAddressController.labelAddress.value == 'primary'
                                ? Colors.white
                                : Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    newAddressController.togglePrimaryAddress(
                      'office',
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: newAddressController.labelAddress.value == 'office'
                          ? ColorPalette().primary
                          : HexColor('#eff4f8'),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Kantor',
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            newAddressController.labelAddress.value == 'office'
                                ? Colors.white
                                : Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
