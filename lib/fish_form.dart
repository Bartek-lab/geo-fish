import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FishForm extends StatefulWidget {
  const FishForm({super.key});

  @override
  State<FishForm> createState() => _FishFormState();
}

class _FishFormState extends State<FishForm> {
  final storage = FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final sizeController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              InputDecorator(
                decoration: const InputDecoration(
                  hintText: 'Enter a fish name',
                  labelText: 'Fish',
                ),
                child: TextFormField(
                  controller: nameController,
                ),
              ),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Size',
                  hintText: 'Enter a fish Size',
                ),
                child: TextFormField(
                  controller: sizeController,
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final size = sizeController.text;

                    // addNewFish(nameController.text, sizeController.text);

                    CollectionReference fishList =
                        FirebaseFirestore.instance.collection('fishList');

                    fishList
                        .add({
                          'name': name,
                          'size': size,
                        })
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                                    "Congratulations! You added your fish to catalog!"),
                                backgroundColor: Colors.lightGreen)))
                        .catchError((error) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                                    "Something went wrong! Please try again"),
                                backgroundColor: Colors.lightGreen)));

                    Navigator.of(context).pop();
                  },
                  child: const Text("Add Fish")),
            ])));
  }
}
