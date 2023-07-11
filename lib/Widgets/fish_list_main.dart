import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fish/Widgets/fish_item.dart';

class MainFishList extends StatefulWidget {
  const MainFishList({
    super.key,
  });

  @override
  State<MainFishList> createState() => _FishListState();
}

class _FishListState extends State<MainFishList> {
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
          .where("isSharedOnMainList", isEqualTo: true)
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
