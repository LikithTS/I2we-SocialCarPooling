import 'dart:io';

import 'package:common/network/repository/CarRepository.dart';
import 'package:common/network/response/car/AddCarResponse.dart';
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

  Future<List<XFile?>?> getCarImages() async {
    List<XFile>? imageFileList = [];
    final picker = ImagePicker();

    final List<XFile>? selectedImages = await picker.pickMultiImage(
        imageQuality: 50, // <- Reduce Image quality
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    if (selectedImages != null && selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    return imageFileList;
  }

  Future<List<AddCarResponse>> getUrlsForCars(int count) async {
    return CarRepository().getCarUrls(count);
  }
}
