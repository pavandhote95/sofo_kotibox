
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../services/location_services.dart';


class SelectLocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);
  final mapCenter = const LatLng(26.9124, 75.7873).obs;
  final currentAddress = ''.obs;
  final currentLocality = ''.obs;

  final isLoading = true.obs;
  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocation();
  }

Future<void> fetchCurrentLocation() async {
  isLoading.value = true;
  final position = await LocationService.getCurrentLocation();
  if (position != null) {
    print('📍 Current Location: ${position.latitude}, ${position.longitude}'); // ← Ye line add karo

    mapCenter.value = LatLng(position.latitude, position.longitude);
    updateAddress(position);
    mapController?.animateCamera(CameraUpdate.newLatLng(mapCenter.value));
  } else {
    print('⚠️ Could not fetch current location.');
  }
  isLoading.value = false;
}
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    mapCenter.value = position.target;
  }

  void onCameraIdle() async {
    final pos = Position(
      latitude: mapCenter.value.latitude,
      longitude: mapCenter.value.longitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0, altitudeAccuracy: 0.0, headingAccuracy: 0.0,
    );
    updateAddress(pos);
  }

Future<void> updateAddress(Position position) async {
  final addressData = await LocationService.getAddressFromLatLng(position);
  if (addressData != null) {
    currentAddress.value = addressData['fullAddress']!;
    currentLocality.value = addressData['locality']!;

    print('📫 Current Address: ${currentAddress.value}');
    print('🏘️ Locality: ${currentLocality.value}');
  } else {
    print('❌ Address not found for current coordinates.');
  }
}


}
