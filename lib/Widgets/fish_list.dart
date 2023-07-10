import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fish/Widgets/fish_item.dart';

class FishList extends StatefulWidget {
  const FishList({required isGlobal, super.key});

  @override
  State<FishList> createState() => _FishListState();
}

class _FishListState extends State<FishList> {
  String currentUserId = "";
  @override
  void initState() {
    super.initState();

    setState(() {
      currentUserId = FirebaseAuth.instance.currentUser!.uid;
    });
  }

  bool isGlobal = true;
  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('fishList');

    return StreamBuilder(
      //TODO distingush list  -> author
      stream: collectionRef
          .where("author", isEqualTo: currentUserId)
          .where("isSharedOnMainList", isEqualTo: !isGlobal)
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
