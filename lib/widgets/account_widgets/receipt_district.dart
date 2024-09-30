import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/component/string_formatter.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ListTileLocation extends StatelessWidget {
  const ListTileLocation({
    super.key,
    required this.location,
  });

  final dynamic location;

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.find<NewAddressController>();
    return InkWell(
      onTap: () {
        if (location.area != 'postalCode') {
          newAddressController.setAddressLocation(
            location.area != 'city'
                ? location.name
                : '${shortenKabupaten(location.type)} ${location.name}',
            location.area,
          );
        } else {
          newAddressController.setAddressLocation(
              location.postalCode, 'postalCode');
        }
        newAddressController.isAddressSetManual.value = true;
        newAddressController.needRebuildTrack.value = true;
        if (location.area == 'province') {
          newAddressController.getCityData(location.id);
        } else if (location.area == 'city') {
          newAddressController.getPostalCodeData(location.idCity);
        }
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeightBox(15),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 15,
                  height: 20,
                  child: Text(
                    location.isFistLetter ? location.name[0] : '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const WidthBox(15),
                Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    location.area == 'city'
                        ? '${shortenKabupaten(location.type)} ${location.name}'
                        : location.area == 'postalCode'
                            ? location.postalCode
                            : location.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const HeightBox(15),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Divider(
                thickness: 0.5,
                height: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletSelectedLocation extends StatelessWidget {
  const BulletSelectedLocation({
    super.key,
    required this.area,
  });

  final String area;

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.find<NewAddressController>();
    final location =
        newAddressController.selectedAddress['selectedAddress']?[area];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const WidthBox(10),
              Text(
                location ?? '',
                maxLines: 1,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black.withOpacity(0.9),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => newAddressController.needRebuildTrack.value
              ? Container(
                  margin: const EdgeInsets.only(left: 14),
                  width: 2,
                  height: newAddressController.isIncreaseHeightTrack(area) &&
                          area != 'city'
                      ? 30
                      : 15,
                  color: Colors.grey[300],
                )
              : Container(
                  margin: const EdgeInsets.only(left: 14),
                  width: 2,
                  height: newAddressController.isIncreaseHeightTrack(area) &&
                          area != 'city'
                      ? 30
                      : 15,
                  color: Colors.grey[300],
                ),
        ),
      ],
    );
  }
}

class ContainerSelectArea extends StatelessWidget {
  const ContainerSelectArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.find<NewAddressController>();
    final code =
        newAddressController.selectedAddress['selectedAddress']?['postalCode'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[400]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: ColorPalette().primary,
              ),
            ),
            child: Transform.scale(
              scale: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette().primary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          const WidthBox(10),
          Obx(
            () => Text(
              !newAddressController.isAllLocationSet.value
                  ? newAddressController.nowCurrentSelectedAddress.value ==
                          'province'
                      ? 'Pilih Provinsi'
                      : newAddressController.nowCurrentSelectedAddress.value ==
                              'city'
                          ? 'Pilih Kota'
                          : 'Pilih Kode Pos'
                  : code ?? '',
              style: TextStyle(
                color: ColorPalette().primary.withOpacity(0.9),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
