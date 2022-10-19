class Questionnarie {
  bool? _visibilityStatus;

  Questionnarie({bool? visibilityStatus}) {
    if (visibilityStatus != null) {
      this._visibilityStatus = visibilityStatus;
    }
  }

  bool? get visibilityStatus => _visibilityStatus;
  set visibilityStatus(bool? visibilityStatus) =>
      _visibilityStatus = visibilityStatus;

  Questionnarie.fromJson(Map<String, dynamic> json) {
    _visibilityStatus = json['visibilityStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visibilityStatus'] = this._visibilityStatus;
    return data;
  }
}