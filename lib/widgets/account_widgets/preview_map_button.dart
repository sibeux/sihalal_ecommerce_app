import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sihalal_ecommerce_app/controller/map_geolocation_controller.dart';
import 'package:sihalal_ecommerce_app/controller/new_address_controller.dart';
import 'package:sihalal_ecommerce_app/screens/account_screen/pin_point_map_screen.dart';
import 'package:sihalal_ecommerce_app/widgets/account_widgets/button_widget.dart';

class PreviewMapButton extends StatelessWidget {
  const PreviewMapButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MapGeolocationController mapGeolocationController =
        Get.put(MapGeolocationController());

    final NewAddressController newAddressController =
        Get.find<NewAddressController>();

    return GestureDetector(
      onTap: () {},
      child: Obx(
        () => mapGeolocationController.selectedLocation.value == null
            ? newAddressController.getIsAllDataValid()
                ? const SetPinPointEnable()
                : const SetPinPointDisable()
            : GestureDetector(
                onTap: () async {
                  await mapGeolocationController.getCurrentLatLng(
                    needFetchMap: false,
                  );
                  Get.to(
                    () => const PinPointMapScreen(),
                    transition: Transition.native,
                    popGesture: false,
                    fullscreenDialog: true,
                  );
                },
                child: AbsorbPointer(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 180,
                    child: Obx(
                      () => GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: mapGeolocationController.centerPosition.value,
                          zoom: 16.0, // Zoom level peta
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          mapGeolocationController.mapController = controller;

                          // Listener untuk perubahan posisi
                          ever(mapGeolocationController.centerPosition,
                              (newPosition) {
                            controller.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: newPosition,
                                  zoom: 16.0,
                                ),
                              ),
                            );
                          });
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId('currentPosition'),
                            position:
                                mapGeolocationController.centerPosition.value,
                          ),
                        },
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
