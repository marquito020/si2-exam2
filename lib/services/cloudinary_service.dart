import 'dart:io';

import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  Future<String?> urlCloudinary(file) async {
    File fileBytes = File(file.path);
    final cloudinary = Cloudinary.signedConfig(
      apiKey: "281217171317886",
      apiSecret: "SGcS7K5qbrJYq4pZ1HjcuJLC24Q",
      cloudName: "dg2ugi96k",
    );
    final response = await cloudinary.upload(
        file: file.path,
        fileBytes: fileBytes.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: 'phone',
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        });
    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      return (response.secureUrl);
    }
    return null;
  }
}
