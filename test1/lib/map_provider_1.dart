import 'package:flutter/foundation.dart';

import 'package:naver_map_plugin/naver_map_plugin.dart' show LocationTrackingMode;
import 'location_class.dart';
import 'location_service_1.dart';

class MapProvider with ChangeNotifier {
  final LocationService _locationService = LocationService();
  final LocationClass initLocation = LocationService.initLocation;

  MapProvider(){
    Future(this.setCurrentLocation);
  }

  LocationTrackingMode _trackingMode = LocationTrackingMode.None;
  LocationTrackingMode get trackingMode => this._trackingMode;
  set trackingMode(LocationTrackingMode m) => throw "error";

  Future<void> setCurrentLocation() async {
    if (await this._locationService.canGetCurrentLocation()){
      this._trackingMode = LocationTrackingMode.Follow;
      this.notifyListeners();
    }
  }

}