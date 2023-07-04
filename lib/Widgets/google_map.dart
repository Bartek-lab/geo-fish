import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  Map({setMarkerValue, required this.markerPosition, super.key});
  LatLng markerPosition;
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late ValueChanged<LatLng> setMarkerValue;

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  void manageState() {
    setMarkerValue(widget.markerPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        'Please mark your location on the map:',
        textAlign: TextAlign.left,
      ),
      SizedBox(
        height: 350,
        width: 420,
        child: GoogleMap(
            zoomGesturesEnabled: true,
            mapType: MapType.satellite,
            initialCameraPosition:
                CameraPosition(target: widget.markerPosition, zoom: 15.0),
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            onLongPress: (position) {
              setState(() {
                widget.markerPosition = position;
              });
            },
            markers: {
              Marker(
                markerId: const MarkerId("marker1"),
                position: widget.markerPosition,
                draggable: true,
                onDragEnd: (value) {
                  setMarkerValue(value);
                },
              )
            }),
      ),
    ]);
  }
}
