import 'dart:convert';

import 'Data.dart';

Postquestionarieapi postquestionarieapiFromJson(String str) => Postquestionarieapi.fromJson(json.decode(str));
String postquestionarieapiToJson(Postquestionarieapi data) => json.encode(data.toJson());
class Postquestionarieapi {
  Postquestionarieapi({
      List<QuestionariePostData>? data,}){
    _data = data;
}

  Postquestionarieapi.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(QuestionariePostData.fromJson(v));
      });
    }
  }
  List<QuestionariePostData>? _data;

  List<QuestionariePostData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}