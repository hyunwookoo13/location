import 'package:geolocator/geolocator.dart';

import 'location_class.dart';

class LocationService {
  static const LocationClass initLocation = LocationClass(latitude: 36.10329895402566, longitude: 129.38878900801046);

  Future<LocationPermission> hasLocationPermission() async => await Geolocator.checkPermission();

  Future<bool> isLocationEnabled() async => await Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> requestLocation() async => await Geolocator.requestPermission();

  Future<LocationClass> currentLocation() async {
    final Position _position = await Geolocator.getCurrentPosition();
    return LocationClass(latitude: _position.latitude, longitude: _position.longitude);
  }

  Future<bool> canGetCurrentLocation() async {
    final LocationPermission _permission = await this.hasLocationPermission();
    if (_permission == LocationPermission.always || _permission == LocationPermission.whileInUse) {
      final bool _enabled = await this.isLocationEnabled();
      if (_enabled) return true;
    }
    return false;
  }
}