import 'dart:convert';

import 'package:common/model/direction.dart';
import 'package:common/utils/CPSessionManager.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialcarpooling/util/CPString.dart';

class DirectionApiRepository {
  static const String baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio? _dio;

  DirectionApiRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Direction> getDirection(
      {required LatLng origin, required LatLng destination}) async {

    final response = await _dio?.get(baseUrl,queryParameters: {
      'origin':'${origin.latitude},${origin.longitude}',
      'destination':'${destination.latitude},${destination.longitude}',
      'key':CPString.apiKey
    });

    if(response!.statusCode==200)
      {
        String directionData = jsonEncode(Direction.fromJson(response.data));
        storeDirectionData(directionData);
        return Direction.fromJson(response.data);
      }

    return null!;
  }

  void storeDirectionData(String directionData) {
      CPSessionManager().setDirectionObject(directionData);
  }
}
