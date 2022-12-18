import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddCarViewModel {
  Future<File?> getRcImage() async {
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
