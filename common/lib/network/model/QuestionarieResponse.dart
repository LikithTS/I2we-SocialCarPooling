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
    if (json['questionarie'] != null) {
      _questionarie = [];
      json['questionarie'].forEach((v) {
        _questionarie?.add(Questionarie.fromJson(v));
      });
    }
  }
  List<Questionarie>? _questionarie;

  List<Questionarie>? get questionarie => _questionarie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_questionarie != null) {
      map['questionarie'] = _questionarie?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}