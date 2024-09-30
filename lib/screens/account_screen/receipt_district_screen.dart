import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/receipt_district.dart';
import 'package:velocity_x/velocity_x.dart';

class ReceiptDistrictScreen extends StatelessWidget {
  const ReceiptDistrictScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.find<NewAddressController>();
    newAddressController.clearSelectedAddress();
    return Scaffold(
      backgroundColor: HexColor('#fefffe'),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: HexColor('#fefffe'),
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Pilih Lokasi'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Obx(
                () => newAddressController.isAddressSetManual.value
                    ? Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Lokasi Terpilih',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    newAddressController
                                        .isAddressSetManual.value = false;
                                    newAddressController
                                        .firstLetterLocation.value = '';
                                    newAddressController.clearSelectedAddress();
                                    newAddressController
                                            .listCurrentLocation.value =
                                        newAddressController.listProvince;
                                  },
                                  child: Text(
                                    'Atur Ulang',
                                    style: TextStyle(
                                      color: ColorPalette().primary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const HeightBox(20),
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (newAddressController
                                                .nowCurrentSelectedAddress
                                                .value ==
                                            'city' ||
                                        newAddressController
                                            .provinceIsSet.value)
                                      const BulletSelectedLocation(
                                        area: 'province',
                                      ),
                                    if (newAddressController
                                            .nowCurrentSelectedAddress.value ==
                                        'district' || newAddressController
                                            .cityIsSet.value)
                                      const BulletSelectedLocation(
                                        area: 'city',
                                      ),
                                    if (newAddressController
                                            .nowCurrentSelectedAddress.value ==
                                        'postalCode' || newAddressController
                                            .districtIsSet.value)
                                      const BulletSelectedLocation(
                                        area: 'district',
                                      ),
                                    const ContainerSelectArea(),
                                    const HeightBox(20),
                                    Obx(
                                      () => Text(
                                        newAddressController
                                                    .nowCurrentSelectedAddress
                                                    .value ==
                                                'province'
                                            ? 'Provinsi'
                                            : newAddressController
                                                        .nowCurrentSelectedAddress
                                                        .value ==
                                                    'city'
                                                ? 'Kota'
                                                : newAddressController
                                                            .nowCurrentSelectedAddress
                                                            .value ==
                                                        'district'
                                                    ? 'Kecamatan'
                                                    : 'Kode Pos',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        color: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UseCurrentLocation(),
                            SizedBox(height: 10),
                            Text(
                              'Provinsi',
                            ),
                          ],
                        ),
                      ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Divider(
                  color: Colors.grey.withOpacity(0.3),
                  thickness: 2,
                  height: 0,
                ),
              )
            ],
          ),
          Expanded(
            child: Obx(
              () => newAddressController.isGetLocationLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: ColorPalette().primary,
                        size: 50,
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          newAddressController.listCurrentLocation.length,
                      itemBuilder: (context, index) {
                        return ListTileLocation(
                          location:
                              newAddressController.listCurrentLocation[index]!,
                        );
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.circular(5),
  );
}
