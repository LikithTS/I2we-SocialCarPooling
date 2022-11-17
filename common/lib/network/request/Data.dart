import 'dart:convert';

QuestionariePostData dataFromJson(String str) => QuestionariePostData.fromJson(json.decode(str));
String dataToJson(QuestionariePostData data) => json.encode(data.toJson());
class QuestionariePostData {
  QuestionariePostData({
      String? id, 
      List<String>? subCategories,}){
    _id = id;
    _subCategories = subCategories;
}

  QuestionariePostData.fromJson(dynamic json) {
    _id = json['id'];
    _subCategories = json['subCategories'] != null ? json['subCategories'].cast<String>() : [];
  }
  String? _id;
  List<String>? _subCategories;

  String? get id => _id;
  List<String>? get subCategories => _subCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['subCategories'] = _subCategories;
    return map;
  }

}