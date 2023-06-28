import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:geo_fish/Services/item_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Widgets/google_map.dart';

class FishForm extends StatefulWidget {
  const FishForm({super.key});

  @override
  State<FishForm> createState() => _FishFormState();
}

class _FishFormState extends State<FishForm> {
  final storage = FirebaseStorage.instance;
  final _itemService = ItemService();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    GeolocatorPlatform.instance.requestPermission();
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
            child: Column(children: <Widget>[
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
              const SizedBox(
                height: 350,
                width: 400,
                child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
                    myLocationEnabled: true),
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final size = sizeController.text;

                    _itemService.addFish(name, size);

                    Navigator.of(context).pop();
                  },
                  child: const Text("Add Fish")),
            ])));
  }
}
