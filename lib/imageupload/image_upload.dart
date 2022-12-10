import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'model/ImageUploadResponse.dart';

Future<String?> uploadImage(File file, String url) async {
  String fileName = file.path.split('/').last;
  String fileType = "image";
  String fileSubType = file.path.split('.').last;

  var arr = List.empty(growable: true);
  arr.add(await MultipartFile.fromFile(file.path, filename: fileName));

  FormData formData = FormData.fromMap({});

  var image = await MultipartFile.fromFile(file.path,
      filename: fileName, contentType: MediaType(fileType, fileSubType));

  formData.files.add(MapEntry("input_files", image));

  Dio dio = Dio();
  dio.options.headers["Content-Type"] = "multipart/form-data";
  Response response = await dio.post(url, data: formData);

  print("uploadImage response : ${response.data}");

  if (response.statusCode == 200) {
    var imageResponse = ImageUploadResponse.fromJson(response.data);
    if (imageResponse.files != null && imageResponse.files!.isNotEmpty) {
      return imageResponse.files!.first.newName!;
    }
  }

  return null;
}
