import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'globals.dart';

class ItemService {
  CollectionReference fishList =
      FirebaseFirestore.instance.collection('fishList');

  Future<void> addFish(String name, String size) async {
    fishList.add({
      'name': name,
      'size': size,
    }).then((value) {
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
