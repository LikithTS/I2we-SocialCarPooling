import 'dart:io';

import 'package:common/network/repository/UpdateUserRepository.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class VerificationViewModel {
  Future<dynamic> getIdentificationUrl() async {
    return UpdateUserRepository().getUserIdentificationUrl();
  }

  Future<dynamic> getUserDrivingLicenseUrl() async {
    return UpdateUserRepository().getUserDrivingLicenseUrl();
  }

  Future<File?> getImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);

    if (pickedFile != null) {
      final file = await _cropImage(pickedFile.path);

      if (file != null) {
        File image = File(file.path);
        return image;
      } else {
        return null;
      }
    } else {
      null;
    }
  }

  Future<CroppedFile?> _cropImage(filePath) async {
    var croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    );
    if (croppedImage != null) {
      return croppedImage;
    } else {
      return null;
    }
  }
}
