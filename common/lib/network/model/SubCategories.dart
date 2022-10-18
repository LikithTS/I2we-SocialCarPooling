class SubCategories {
  String? _id;
  String? _name;
  bool? _enabled;
  String? _questionnarieId;

  SubCategories(
      {String? id, String? name, bool? enabled, String? questionnarieId}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (enabled != null) {
      this._enabled = enabled;
    }
    if (questionnarieId != null) {
      this._questionnarieId = questionnarieId;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  bool? get enabled => _enabled;
  set enabled(bool? enabled) => _enabled = enabled;
  String? get questionnarieId => _questionnarieId;
  set questionnarieId(String? questionnarieId) =>
      _questionnarieId = questionnarieId;

  SubCategories.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _enabled = json['enabled'];
    _questionnarieId = json['questionnarieId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['enabled'] = this._enabled;
    data['questionnarieId'] = this._questionnarieId;
    return data;
  }
}