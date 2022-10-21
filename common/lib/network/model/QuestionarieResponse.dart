import 'dart:convert';

import 'QuestionarieCategory.dart';

QuestionarieResponse questionarieResponseFromJson(String str) => QuestionarieResponse.fromJson(json.decode(str));
String questionarieResponseToJson(QuestionarieResponse data) => json.encode(data.toJson());
class QuestionarieResponse {
  QuestionarieResponse({
      List<Questionarie>? questionarie,}){
    _questionarie = questionarie;
}

  QuestionarieResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _questionarie = [];
      json['data'].forEach((v) {
        _questionarie?.add(Questionarie.fromJson(v));
      });
    }
  }
  List<Questionarie>? _questionarie;

  List<Questionarie>? get questionarie => _questionarie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_questionarie != null) {
      map['data'] = _questionarie?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}