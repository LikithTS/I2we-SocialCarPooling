import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AwsApi {
  Future<Response?> uploadToSignedUrl(File file, String signedUrl) async {
    try {
      Uint8List bytes = await file.readAsBytes();
      Uri uri = Uri.parse(signedUrl);
      var response = await put(uri, body: bytes);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<void> uploadImage(String url, File image) async {
    try {
      Uint8List bytes = await image.readAsBytes();
      Uri uri = Uri.parse(url);
      var response = await http.put(uri, body: bytes);
      print("call response upload   : " + response.request.toString());
      print("call response upload  body : " + response.body.toString());
      if (response.statusCode == 200) {
        print("aws image upload" + response.toString());
        print("success");
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }

/*  Future<void> uploadImage(File imageFile, String url, String imagetype) async {
    final length = await imageFile.length();
    final path = imageFile.path;
    print('Uploading image length: $length path:$path to url:$url');
    try {
      var response = await http.put(url,
          body: imageFile.readAsBytesSync(),
          headers: {"Content-Type": "image/" + imagetype});
      print("Uploading image status code: ${response.statusCode}");
      print("Uploading image result: ${response.body}");
      return;
    } catch (error) {
      print('Error uploading:' + error.toString());
      throw error;
    }
  }*/
}
