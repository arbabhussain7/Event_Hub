import 'package:eventhub/constant/colors/colors.dart';
import 'package:eventhub/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends GetView<MapScreenController> {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MapScreenController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () =>
                controller.isLoading.value
                    ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blueColor,
                      ),
                    )
                    : FlutterMap(
                      mapController: controller.mapController,
                      options: MapOptions(
                        initialCenter:
                            controller.currentLocation.value ??
                            const LatLng(0, 0),
                        initialZoom: 2,
                        minZoom: 0,
                        maxZoom: 100,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        ),
                        const CurrentLocationLayer(
                          style: LocationMarkerStyle(
                            marker: DefaultLocationMarker(
                              child: Icon(
                                Icons.location_pin,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            markerSize: Size(35, 35),
                            markerDirection: MarkerDirection.heading,
                          ),
                        ),
                        Obx(
                          () =>
                              controller.destination.value != null
                                  ? MarkerLayer(
                                    markers: [
                                      Marker(
                                        height: 50.h,
                                        width: 50.w,
                                        point: controller.destination.value!,
                                        child: const Icon(
                                          Icons.location_pin,
                                          color: AppColors.redColor,
                                        ),
                                      ),
                                    ],
                                  )
                                  : const SizedBox(),
                        ),
                        Obx(
                          () =>
                              (controller.currentLocation.value != null &&
                                      controller.destination.value != null &&
                                      controller.route.isNotEmpty)
                                  ? PolylineLayer(
                                    polylines: [
                                      Polyline(
                                        points: controller.route,
                                        strokeWidth: 5,
                                        color: AppColors.redColor,
                                      ),
                                    ],
                                  )
                                  : const SizedBox(),
                        ),
                      ],
                    ),
          ),
          Positioned(
            top: 39,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.locationController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.whiteColor,
                        hintText: 'Enter a Location',
                        hintStyle: TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 22.w),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      final location =
                          controller.locationController.text.trim();
                      if (location.isNotEmpty) {
                        controller.fetchCoordinatePoints(location);
                      }
                    },
                    icon: Container(
                      padding: EdgeInsets.all(9.r),
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToUserCurrentLocation,
        elevation: 0,
        backgroundColor: AppColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(33.r),
        ),
        child: Icon(
          Icons.my_location,
          color: AppColors.whiteColor,
          size: 30.sp,
        ),
      ),
    );
  }
}
