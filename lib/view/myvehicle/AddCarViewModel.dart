import 'dart:developer';
import 'dart:io';

import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/response/car/AddCarResponse.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddCarViewModel {

  Future<File?> getRcImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // Change this line to open the gallery
      imageQuality: 50, // Reduce Image quality
      maxHeight: 500, // Limit image height
      maxWidth: 500, // Limit image width
    );

    if (pickedFile != null) {
      final file = await _cropImage(pickedFile.path);

      if (file != null) {
        File image = File(file.path);
        return image;
      } else {
        return null;
      }
    } else {
      return null; // Return null if no image was picked
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


  Future<List<XFile>?> getCarImages() async {
    try {
      final picker = ImagePicker();
      final List<XFile> selectedImages = await picker.pickMultiImage(
        imageQuality: 50, // Reduce image quality
        maxHeight: 500, // Limit image height
        maxWidth: 500, // Limit image width
      );

      if (selectedImages.isNotEmpty) {
        return selectedImages;
      } else {
        // No images were selected.
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during image selection.
      log('Error selecting images: $e');
      return null;
    }
  }

  Future<List<AddCarResponse>> getUrlsForCars(int count) async {
    return CarRepository().getCarUrls(count);
  }
}
