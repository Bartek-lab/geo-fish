import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geo_fish/Services/item_services.dart';
import 'package:geo_fish/Services/geo_locator.dart';

class FishForm extends StatefulWidget {
  const FishForm({super.key, required this.uploadedImageUrl});

  final String uploadedImageUrl;

  @override
  State<FishForm> createState() => _FishFormState();
}

class _FishFormState extends State<FishForm> {
  final _itemService = ItemService();
  final _formKey = GlobalKey<FormState>();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  late LatLng _markerPosition;

  // _FishFormState(this._currentPosition);

  final nameController = TextEditingController();
  final sizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GeolocatorService().determinePosition().then((value) => setState(() {
          _markerPosition = LatLng(value.latitude, value.longitude);
        }));
  }

  @override
  void dispose() {
    nameController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: SizedBox(
                    height: 1500,
                    child: Column(
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InputDecorator(
                            decoration: const InputDecoration(
                              hintText: 'Enter a fish name',
                              labelText: 'Fish',
                            ),
                            child: TextFormField(
                              controller: nameController,
                            ),
                          ),
                          InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Size',
                              hintText: 'Enter a fish Size',
                            ),
                            child: TextFormField(
                              controller: sizeController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            height: 350,
                            width: 420,
                            child: widget.uploadedImageUrl != "" &&
                                    widget.uploadedImageUrl != "badUrl"
                                ? Image.network(
                                    widget.uploadedImageUrl,
                                  )
                                : const CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: 350,
                            width: 420,
                            child: GoogleMap(
                                // zoomGesturesEnabled: true,
                                mapType: MapType.satellite,
                                initialCameraPosition: CameraPosition(
                                    target: _markerPosition, zoom: 15.0),
                                myLocationEnabled: true,
                                onMapCreated: (GoogleMapController controller) {
                                  _mapController.complete(controller);
                                },
                                onLongPress: (position) {
                                  setState(() {
                                    _markerPosition = position;
                                  });
                                },
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("marker1"),
                                    position: _markerPosition,
                                    draggable: true,
                                    onDragEnd: (value) {
                                      setState(() {
                                        _markerPosition = value;
                                      });
                                    },
                                  )
                                }),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                final name = nameController.text;
                                final size = sizeController.text;
                                final position = {
                                  'lat': _markerPosition.latitude,
                                  'lng': _markerPosition.longitude
                                };

                                _itemService.addFish(name, size, position,
                                    widget.uploadedImageUrl);

                                Navigator.of(context).pop();
                              },
                              child: const Text("Add Fish")),
                        ])))));
  }
}
