import 'dart:convert';

Subcategory subcategoryFromJson(String str) => Subcategory.fromJson(json.decode(str));
String subcategoryToJson(Subcategory data) => json.encode(data.toJson());
class Subcategory {
  Subcategory({
      int? id, 
      String? name, 
      bool? enabled,}){
    _id = id;
    _name = name;
    _enabled = enabled;
}

  Subcategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _enabled = json['enabled'];
  }
  int? _id;
  String? _name;
  bool? _enabled;

  int? get id => _id;
  String? get name => _name;
  bool? get enabled => _enabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['enabled'] = _enabled;
    return map;
  }

}