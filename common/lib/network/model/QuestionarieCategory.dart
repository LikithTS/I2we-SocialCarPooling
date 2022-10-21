import 'dart:convert';

import 'package:common/network/model/SubCategories.dart';


Questionarie questionarieFromJson(String str) => Questionarie.fromJson(json.decode(str));
String questionarieToJson(Questionarie data) => json.encode(data.toJson());
class Questionarie {
  Questionarie({
      String? category,
    String? id,
      bool? enabled, 
      List<SubCategories>? subcategory,}){
    _category = category;
    _id = id;
    _enabled = enabled;
    _subcategory = subcategory;
}

  Questionarie.fromJson(dynamic json) {
    _category = json['category'];
    _id = json['id'];
    _enabled = json['enabled'];
    if (json['subCategories'] != null) {
      _subcategory = [];
      json['subCategories'].forEach((v) {
        _subcategory?.add(SubCategories.fromJson(v));
      });
    }
  }
  String? _category;
  String? _id;
  bool? _enabled;
  List<SubCategories>? _subcategory;

  String? get category => _category;
  String? get id => _id;
  bool? get enabled => _enabled;
  List<SubCategories>? get subcategory => _subcategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = _category;
    map['id'] = _id;
    map['enabled'] = _enabled;
    if (_subcategory != null) {
      map['subCategories'] = _subcategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}