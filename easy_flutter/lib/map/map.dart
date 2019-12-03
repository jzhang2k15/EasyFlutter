import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  createState() {
    return MyMapState();
  }
}

class MyMapState extends State<MyMap> {
  GoogleMapController _mapController;

  final LatLng _initialLatlng = LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地图展示'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialLatlng,
          zoom: 11.0,
        ),
      ),

    );
  }

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;
  }
}
