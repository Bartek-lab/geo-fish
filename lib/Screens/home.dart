import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:geo_fish/Services/image_services.dart';

import '../Widgets/fish_list.dart';
import 'fish_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final String uploadedImageUrl = "";

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
          final navigator = Navigator.of(context);

          ImageService().takePicture().then((url) => navigator.push(
                MaterialPageRoute(
                    builder: (context) => FishForm(uploadedImageUrl: url)),
              ));
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
