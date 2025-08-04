// services/location_service.dart
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    if (kIsWeb) {
      print('Geolocation is not supported on Web');
      return null;
    } else {
      try {
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          await Geolocator.openLocationSettings();
          throw 'Location services are disabled';
        }
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            throw 'Location permission denied';
          }
        }
        if (permission == LocationPermission.deniedForever) {
          throw 'Permission permanently denied';
        }
        return await Geolocator.getCurrentPosition(
          // ignore: deprecated_member_use
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print('Location error: $e');
        return null;
      }
    }
  }



 static Future<Map<String, String>?> getAddressFromLatLng(Position position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      final String fullAddress = [
        place.name,
        place.street,
        place.subLocality,
        place.locality,
        // place.subAdministrativeArea,
        place.postalCode,
      ].where((element) => element != null && element.isNotEmpty).join(', ');
      return {
        'fullAddress': fullAddress,
      };
    }
    return null;
  } catch (e) {
    print("Geocoding error: $e");
    return null;
  }
}



}
