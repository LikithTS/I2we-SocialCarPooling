import 'dart:convert';

import 'Subcategory.dart';

Questionarie questionarieFromJson(String str) => Questionarie.fromJson(json.decode(str));
String questionarieToJson(Questionarie data) => json.encode(data.toJson());
class Questionarie {
  Questionarie({
      String? category, 
      int? id, 
      bool? enabled, 
      List<Subcategory>? subcategory,}){
    _category = category;
    _id = id;
    _enabled = enabled;
    _subcategory = subcategory;
}

  Questionarie.fromJson(dynamic json) {
    _category = json['category'];
    _id = json['id'];
    _enabled = json['enabled'];
    if (json['subcategory'] != null) {
      _subcategory = [];
      json['subcategory'].forEach((v) {
        _subcategory?.add(Subcategory.fromJson(v));
      });
    }
  }
  String? _category;
  int? _id;
  bool? _enabled;
  List<Subcategory>? _subcategory;

  String? get category => _category;
  int? get id => _id;
  bool? get enabled => _enabled;
  List<Subcategory>? get subcategory => _subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = _category;
    map['id'] = _id;
    map['enabled'] = _enabled;
    if (_subcategory != null) {
      map['subcategory'] = _subcategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}