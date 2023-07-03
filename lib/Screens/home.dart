import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:image_picker/image_picker.dart';

import '../Widgets/fish_list.dart';
import 'fish_form.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  String uploadedImageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: const [],
                  ),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      // body:
      body: const FishList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // print(await currentPosition);
          //TODO
          // final navigator = Navigator.of(context);

          XFile? photo =
              await ImagePicker().pickImage(source: ImageSource.camera);
          print('${photo?.path}');

          if (photo == null) return;

          String imageId = DateTime.now().millisecondsSinceEpoch.toString();

          Reference firestorageImages =
              FirebaseStorage.instance.ref().child('images');

          Reference uploadedImage = firestorageImages.child(imageId);

          try {
            uploadedImage.putFile(File(photo.path));
            uploadedImageUrl = await uploadedImage.getDownloadURL();

            print(uploadedImageUrl);
          } catch (error) {
            print(error);
          }

          // navigator.push(
          //   MaterialPageRoute(
          //     builder: (context) => FishForm(
          //       uploadedImageUrl: uploadedImageUrl,
          //     ),
          //   ),
          // );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
