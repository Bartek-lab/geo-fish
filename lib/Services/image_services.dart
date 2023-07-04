import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<dynamic> takePicture() async {
    String imageUrl = "imageUrl";
    String imageId = DateTime.now().millisecondsSinceEpoch.toString();

    Reference firestorageImages =
        FirebaseStorage.instance.ref().child('images');

    Reference uploadedImage = firestorageImages.child(imageId);

    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);

    if (file == null) return;
    // return

    try {
      await uploadedImage.putFile(File(file.path));
      imageUrl = await uploadedImage.getDownloadURL();
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }
}
