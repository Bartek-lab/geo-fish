import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../globals.dart';

class ItemService {
  CollectionReference fishList =
      FirebaseFirestore.instance.collection('fishList');

  Future<void> addFish(
    String name,
    String size,
    Map<String, double> position,
  ) async {
    fishList
        .add({'name': name, 'size': size, 'position': position}).then((value) {
      const SnackBar snackBar = SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text("Congratulations! You added your fish to catalog!"));
      snackbarKey.currentState?.showSnackBar(snackBar);
    }).catchError((error) {
      const SnackBar snackBar = SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Something went wrong :( Please try again."));
      snackbarKey.currentState?.showSnackBar(snackBar);
    });
  }
}
