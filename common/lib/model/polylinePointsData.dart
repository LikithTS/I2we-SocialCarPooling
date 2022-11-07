

class PolylinePointsData {
  String? points;

  PolylinePointsData({this.points});

  PolylinePointsData.fromJson(Map<String, dynamic> json) {
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    return data;
  }
}