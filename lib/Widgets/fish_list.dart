import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geo_fish/Widgets/fish_item.dart';

class FishList extends StatelessWidget {
  FishList({required this.isGlobal, super.key});

  bool isGlobal = true;
  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('fishList');

    final data =
        collectionRef.where("isSharedOnMainList", isEqualTo: isGlobal).get();
    return StreamBuilder(
      stream: collectionRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                return FishItem(data);
              });
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
