
class FirebaseTokenApi {
  FirebaseTokenApi({
    String? token,
  }) {
    _token = token;
  }

  FirebaseTokenApi.fromJson(dynamic json) {
    _token = json['firebaseToken'];
  }

  String? _token;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firebaseToken'] = _token;
    return map;
  }
}