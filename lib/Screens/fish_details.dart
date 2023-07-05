import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:geo_fish/Widgets/google_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FishDetails extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final QueryDocumentSnapshot<Object?> data;

  FishDetails(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    LatLng position = LatLng(data['position']['lat'], data['position']['lng']);
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: SizedBox(
                    child: Column(
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                        left: 5, top: 15, right: 5, bottom: 10),
                    child: TextFormField(
                      initialValue: data['name'],
                      decoration: InputDecoration(
                          labelText: "Fish Name",
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                      readOnly: true,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 5, top: 10, right: 5, bottom: 10),
                    child: TextFormField(
                      initialValue: data['size'],
                      decoration: InputDecoration(
                          labelText: "Size",
                          filled: true,
                          fillColor: Colors.blue.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                      readOnly: true,
                    ),
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
                          data['imageUrl'],
                          loadingBuilder: (context, child, loadingProgress) {
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
                  Map(markerPosition: position, readOnly: true),
                ])))));
  }
}
