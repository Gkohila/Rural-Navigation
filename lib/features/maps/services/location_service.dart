import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {

  static Future<Position?> getCurrentLocation() async {

    bool serviceEnabled =
        await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission =
        await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission();
    }

    if (permission ==
            LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<String> getLocationName(
    double lat,
    double lon,
  ) async {

    try {

      final placemarks =
          await placemarkFromCoordinates(
        lat,
        lon,
      );

      if (placemarks.isEmpty) {
        return "Unknown";
      }

      final place =
          placemarks.first;

      if ((place.subLocality ?? '')
          .trim()
          .isNotEmpty) {
        return place.subLocality!;
      }

      if ((place.locality ?? '')
          .trim()
          .isNotEmpty) {
        return place.locality!;
      }

      if ((place.subAdministrativeArea ?? '')
          .trim()
          .isNotEmpty) {
        return place.subAdministrativeArea!;
      }

      return "Unknown";

    } catch (e) {

      return "Unknown";
    }
  }
}