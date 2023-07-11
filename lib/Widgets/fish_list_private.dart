import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fish/Widgets/fish_item.dart';

class PrivateFishList extends StatefulWidget {
  const PrivateFishList({
    super.key,
  });

  @override
  State<PrivateFishList> createState() => _FishListState();
}

class _FishListState extends State<PrivateFishList> {
  String currentUserId = "";

  @override
  void initState() {
    super.initState();

    setState(() {
      currentUserId = FirebaseAuth.instance.currentUser!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('fishList');

    return StreamBuilder(
      stream: collectionRef
          .where("author", isEqualTo: currentUserId)
          .where("isSharedOnMainList", isEqualTo: false)
          .snapshots(),
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
