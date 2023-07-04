import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FishItem extends StatelessWidget {
  const FishItem(this.data, {super.key});
  final QueryDocumentSnapshot<Object?> data;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
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
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      data['name'],
                    )),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(data['size']),
                )
              ]))
    ]);
  }
}
