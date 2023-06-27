import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geo_fish/Services/geo_locator.dart';
import '../Widgets/fish_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final geolocatorService = GeolocatorService();
    Future<Position> currentPosition = geolocatorService.determinePosition();

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
          print(await currentPosition);

          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const FishForm(),
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
