import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // CrudMedthods crudObj = CrudMedthods();

  @override
  Widget build(BuildContext context) {
    return const FishList();
  }
}

class FishList extends StatelessWidget {
  const FishList({super.key});
  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('fishList');
    return StreamBuilder(
      stream: collectionRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];

              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['size']),
              );
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
