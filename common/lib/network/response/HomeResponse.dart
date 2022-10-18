
import 'dart:convert';

import '../model/MyCars.dart';
import '../model/Profile.dart';
import '../model/Questionnarie.dart';
import '../model/RecentRides.dart';
import '../model/UpcomingRides.dart';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String loginResponseToJson(HomeResponse data) => json.encode(data.toJson());


class HomeResponse {
  List<UpcomingRides>? _upcomingRides;
  List<RecentRides>? _recentRides;
  Questionnarie? _questionnarie;
  Profile? _profile;
  List<MyCars>? _myCars;

  HomeResponse(
      {List<UpcomingRides>? upcomingRides,
        List<RecentRides>? recentRides,
        Questionnarie? questionnarie,
        Profile? profile,
        List<MyCars>? myCars}) {
    if (upcomingRides != null) {
      this._upcomingRides = upcomingRides;
    }
    if (recentRides != null) {
      this._recentRides = recentRides;
    }
    if (questionnarie != null) {
      this._questionnarie = questionnarie;
    }
    if (profile != null) {
      this._profile = profile;
    }
    if (myCars != null) {
      this._myCars = myCars;
    }
  }

  List<UpcomingRides>? get upcomingRides => _upcomingRides;
  set upcomingRides(List<UpcomingRides>? upcomingRides) =>
      _upcomingRides = upcomingRides;
  List<RecentRides>? get recentRides => _recentRides;
  set recentRides(List<RecentRides>? recentRides) => _recentRides = recentRides;
  Questionnarie? get questionnarie => _questionnarie;
  set questionnarie(Questionnarie? questionnarie) =>
      _questionnarie = questionnarie;
  Profile? get profile => _profile;
  set profile(Profile? profile) => _profile = profile;
  List<MyCars>? get myCars => _myCars;
  set myCars(List<MyCars>? myCars) => _myCars = myCars;

  HomeResponse.fromJson(Map<String, dynamic> json) {
    if (json['upcomingRides'] != null) {
      _upcomingRides = <UpcomingRides>[];
      json['upcomingRides'].forEach((v) {
        _upcomingRides!.add(new UpcomingRides.fromJson(v));
      });
    }
    if (json['recentRides'] != null) {
      _recentRides = <RecentRides>[];
      json['recentRides'].forEach((v) {
        _recentRides!.add(new RecentRides.fromJson(v));
      });
    }
    _questionnarie = json['questionnarie'] != null
        ? new Questionnarie.fromJson(json['questionnarie'])
        : null;
    _profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    if (json['myCars'] != null) {
      _myCars = <MyCars>[];
      json['myCars'].forEach((v) {
        _myCars!.add(new MyCars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._upcomingRides != null) {
      data['upcomingRides'] =
          this._upcomingRides!.map((v) => v.toJson()).toList();
    }
    if (this._recentRides != null) {
      data['recentRides'] = this._recentRides!.map((v) => v.toJson()).toList();
    }
    if (this._questionnarie != null) {
      data['questionnarie'] = this._questionnarie!.toJson();
    }
    if (this._profile != null) {
      data['profile'] = this._profile!.toJson();
    }
    if (this._myCars != null) {
      data['myCars'] = this._myCars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}