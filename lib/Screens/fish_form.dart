import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fish/Services/geo_locator.dart';
import 'package:geo_fish/Services/item_services.dart';
import 'package:geo_fish/Widgets/google_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FishForm extends StatefulWidget {
  const FishForm({
    super.key,
    required this.uploadedImageUrl,
  });

  final String uploadedImageUrl;

  @override
  State<FishForm> createState() => _FishFormState();
}

class _FishFormState extends State<FishForm> {
  final _itemService = ItemService();
  final _formKey = GlobalKey<FormState>();

  late LatLng _markerPosition;
  String currentUserId = "";
  bool isSharedOnMainList = false;

  final nameController = TextEditingController();
  final sizeController = TextEditingController();

  void changeMarkerPostion(value) {
    setState(() {
      _markerPosition = value;
    });
  }

  @override
  void initState() {
    super.initState();
    GeolocatorService().determinePosition().then((value) => setState(() {
          _markerPosition = LatLng(value.latitude, value.longitude);
        }));

    setState(() {
      currentUserId = FirebaseAuth.instance.currentUser!.uid;
    });
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
                    height: 1000,
                    child: Column(
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5, top: 15, right: 5, bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Fish Name",
                                  filled: true,
                                  fillColor: Colors.blue.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )),
                              controller: nameController,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5, top: 10, right: 5, bottom: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                  labelText: "Size",
                                  filled: true,
                                  fillColor: Colors.blue.shade100,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )),
                              controller: sizeController,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5, top: 10, right: 5, bottom: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Share fish for all users:"),
                                  Switch(
                                    value: isSharedOnMainList,
                                    thumbColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.blueGrey),
                                    onChanged: (bool value) {
                                      setState(() {
                                        isSharedOnMainList = value;
                                        print(value);
                                      });
                                    },
                                  ),
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 5, top: 10, right: 5, bottom: 10),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                child: Image.network(
                                  widget.uploadedImageUrl,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                  height: 180,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Map(
                            markerPosition: _markerPosition,
                            setMarkerValue: changeMarkerPostion,
                            readOnly: false,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print(isSharedOnMainList);
                                final name = nameController.text;
                                final size = sizeController.text;
                                final position = {
                                  'lat': _markerPosition.latitude,
                                  'lng': _markerPosition.longitude
                                };

                                _itemService.addFish(
                                  name,
                                  size,
                                  position,
                                  currentUserId,
                                  isSharedOnMainList,
                                  widget.uploadedImageUrl,
                                );

                                Navigator.of(context).pop();
                              },
                              child: const Text("Add Fish")),
                        ])))));
  }
}
