import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late double lat=0.0;
  late double lng=0.0;
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) {
      setState(() {
        lat = res.latitude!;
        lng = res.longitude!;
      });
    });
  }

  Completer<NaverMapController> _controller = Completer();
  MapType _mapType = MapType.Basic;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geolocation"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text("Lat: $lat, Lng: $lng"),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Locate Me"),
                onPressed: () => _locateMe(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }
}