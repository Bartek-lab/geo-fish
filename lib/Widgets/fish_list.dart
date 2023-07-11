import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geo_fish/Widgets/fish_item.dart';

class FishList extends StatefulWidget {
  const FishList({
    required this.isSharedOnMainList,
    super.key,
  });
  final bool isSharedOnMainList;
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

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('fishList');
    print(widget.isSharedOnMainList);
    return StreamBuilder(
      //TODO distingush list  -> author
      stream: collectionRef
          // .where("author", isEqualTo: currentUserId)
          .where("isSharedOnMainList", isEqualTo: widget.isSharedOnMainList)
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
