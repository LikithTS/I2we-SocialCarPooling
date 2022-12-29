import 'dart:developer';
import 'dart:io';

import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel {
  Future<dynamic> getUserProfileUrl() async {
    return UpdateUserRepository().getUserProfileUrl();
  }

  Future<File> getProfileImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    log("Image picked file ${pickedFile!.path}");
    File image = File(pickedFile.path);

    return image;
  }
}
