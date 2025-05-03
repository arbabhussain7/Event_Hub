import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Controller class for MapScreen

// Controller class for MapScreen
class MapScreenController extends GetxController {
  final mapController = MapController();
  final Location location = Location();
  final locationController = TextEditingController();

  final RxBool isLoading = true.obs;
  final Rx<LatLng?> currentLocation = Rx<LatLng?>(null);
  final Rx<LatLng?> destination = Rx<LatLng?>(null);
  final RxList<LatLng> route = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeLocation();
  }

  @override
  void onClose() {
    locationController.dispose();
    super.onClose();
  }

  Future<void> initializeLocation() async {
    if (!await checkRequestPermission()) return;

    location.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        currentLocation.value = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        isLoading.value = false;
      }
    });
  }

  Future<bool> checkRequestPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<void> fetchCoordinatePoints(String location) async {
    try {
      Get.snackbar(
        'Searching',
        'Looking for location: $location',
        duration: Duration(seconds: 1),
      );

      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(location)}&format=json&limit=1',
      );

      print('Searching location: $url');

      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'EventHubApp/1.0',
          'Accept-Language': 'en-US,en;q=0.9',
        },
      );

      print('Location search response: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(
          'Location data: ${data.toString().substring(0, min(100, data.toString().length))}...',
        );

        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          final displayName = data[0]['display_name'];

          print('Found location: $displayName at $lat,$lon');
          destination.value = LatLng(lat, lon);

          Get.snackbar(
            'Location Found',
            displayName,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );

          // Add a small delay to ensure the UI updates before fetching the route
          await Future.delayed(Duration(milliseconds: 500));
          await fetchRoute();
        } else {
          Get.snackbar(
            'Not Found',
            'Location "$location" not found. Try a different search term.',
          );
        }
      } else {
        Get.snackbar(
          'Search Error',
          'Error searching for location: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Exception during location search: $e');
      Get.snackbar('Error', 'Failed to search location: $e');
    }
  }

  Future<void> fetchRoute() async {
    if (currentLocation.value == null || destination.value == null) return;

    try {
      // Fixed URL format - removed extra spaces and ensured proper formatting
      final url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/'
        '${currentLocation.value!.longitude},${currentLocation.value!.latitude};'
        '${destination.value!.longitude},${destination.value!.latitude}'
        '?overview=full&geometries=polyline',
      );

      print('Request URL: ${url.toString()}');

      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print(
        'Response body: ${response.body.substring(0, min(100, response.body.length))}...',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final geometry = data['routes'][0]['geometry'];
          route.value = _decodePolyline(geometry);

          // After successfully adding the route, center the map to show both points
          fitMapToPoints();
        } else {
          Get.snackbar('Route Error', 'No route found between locations');
        }
      } else {
        Get.snackbar('Error', 'Error fetching route: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during route fetch: $e');
      Get.snackbar('Error', 'Failed to fetch route: $e');
    }
  }

  void fitMapToPoints() {
    if (currentLocation.value != null && destination.value != null) {
      try {
        final points = [currentLocation.value!, destination.value!];
        final latitudes = points.map((p) => p.latitude).toList();
        final longitudes = points.map((p) => p.longitude).toList();
        final southWest = LatLng(
          latitudes.reduce((a, b) => a < b ? a : b),
          longitudes.reduce((a, b) => a < b ? a : b),
        );
        final northEast = LatLng(
          latitudes.reduce((a, b) => a > b ? a : b),
          longitudes.reduce((a, b) => a > b ? a : b),
        );

        final centerLat = (southWest.latitude + northEast.latitude) / 2;
        final centerLng = (southWest.longitude + northEast.longitude) / 2;
        final center = LatLng(centerLat, centerLng);
        final distance = calculateDistance(
          southWest.latitude,
          southWest.longitude,
          northEast.latitude,
          northEast.longitude,
        );

        double zoom = 13;
        if (distance > 10) zoom = 10;
        if (distance > 50) zoom = 8;
        if (distance > 200) zoom = 6;
        if (distance > 500) zoom = 5;
        mapController.move(center, zoom);
      } catch (e) {
        print('Error fitting map to points: $e');
      }
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0;
    final dLat = (lat2 - lat1) * (pi / 180);
    final dLon = (lon2 - lon1) * (pi / 180);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180)) *
            cos(lat2 * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return points;
  }

  void goToUserCurrentLocation() {
    if (currentLocation.value != null) {
      mapController.move(currentLocation.value!, 15);
    } else {
      Get.snackbar('Location Error', 'Current location not available');
    }
  }
}
