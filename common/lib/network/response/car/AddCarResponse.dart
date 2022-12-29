class AddCarResponse {
  String? url;
  String? key;

  AddCarResponse({this.url, this.key});

  AddCarResponse.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['key'] = this.key;
    return data;
  }
}
