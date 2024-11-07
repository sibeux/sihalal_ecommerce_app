import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sihalal_ecommerce_app/component/color_palette.dart';
import 'package:sihalal_ecommerce_app/controller/map_geolocation_controller.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/controller/send_user_address_controller.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/delete_address_modal.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/new_address_form.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/preview_map_button.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/switcher_address.dart';
import 'package:velocity_x/velocity_x.dart';

class CrudAddressScreen extends StatelessWidget {
  const CrudAddressScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final newAddressController = Get.put(NewAddressController());
    final mapGeolocationController = Get.put(MapGeolocationController());
    final sendUserAddressController = Get.put(SendUserAddressController());
    final int index = Get.arguments ?? -1;

    if (index != -1) {
      newAddressController.setDataEditAddress(index);
    }
    return Stack(
      children: [
        Scaffold(
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
            title: Text(title),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            actions: [
              (title == 'Tambah Alamat')
                  ? const SizedBox()
                  : (title != 'Tambah Alamat' &&
                          (!newAddressController.isPrimaryAddress.value &&
                              !newAddressController.isStoreAddress.value))
                      ? GestureDetector(
                          onTap: () {
                            showModalDeleteAddress(context, index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Hapus Alamat',
                              style: TextStyle(
                                color: ColorPalette().primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                              msg:
                                  'Alamat tidak dapat dihapus karena merupakan alamat utama atau alamat toko',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black.withOpacity(0.8),
                              textColor: Colors.white,
                              fontSize: 10.0,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Hapus Alamat',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
            ],
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(
                    height: 0.5,
                    thickness: 0.5,
                  ),
                  const HeightBox(15),
                  const ReceiptName(),
                  const HeightBox(5),
                  !newAddressController.getIsNameValid() &&
                          !newAddressController.getIsNameEmpty()
                      ? Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '*Nama tidak boleh mengandung angka atau simbol',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red.withOpacity(1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const HeightBox(10),
                  const ReceiptPhone(),
                  const HeightBox(5),
                  !newAddressController.getIsPhoneValid() &&
                          !newAddressController.getIsPhoneEmpty()
                      ? Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '*Format nomor telepon: 08xx-xxxx-xxxx',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.red.withOpacity(1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const HeightBox(10),
                  ReceiptDistrict(
                    isNewAddress: title == 'Tambah Alamat',
                  ),
                  const HeightBox(15),
                  const ReceiptStreet(),
                  const HeightBox(15),
                  Divider(
                    color: HexColor('#eff4f8'),
                    height: 8,
                    thickness: 8,
                  ),
                  const PreviewMapButton(),
                  Divider(
                    color: HexColor('#eff4f8'),
                    height: 8,
                    thickness: 8,
                  ),
                  const HeightBox(5),
                  PrimaryAddressSwitcher(
                      newAddressController: newAddressController),
                  const HeightBox(5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 0.5,
                      thickness: 0.5,
                    ),
                  ),
                  const HeightBox(5),
                  StoreAddressSwitcher(
                      newAddressController: newAddressController),
                  const HeightBox(5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 0.5,
                      thickness: 0.5,
                    ),
                  ),
                  const HeightBox(10),
                  const LabelAddressSwitcher(),
                  const HeightBox(10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      height: 0.5,
                      thickness: 0.5,
                    ),
                  ),
                  const HeightBox(20),
                  Obx(
                    () => newAddressController.getIsAllDataValid() &&
                            mapGeolocationController.selectedLocation.value !=
                                null
                        ? EnableSendNewAddress(
                            isNewAddress: title == 'Tambah Alamat',
                            index: index,
                          )
                        : const DisableSendNewAddress(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() => mapGeolocationController.isLoadingMap.value ||
                sendUserAddressController.isLoadingSendAddress.value ||
                newAddressController.isLoadingSetEditAddress.value
            ? const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              )
            : const SizedBox()),
        Obx(
          () => mapGeolocationController.isLoadingMap.value ||
                  sendUserAddressController.isLoadingSendAddress.value ||
                  newAddressController.isLoadingSetEditAddress.value
              ? Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
