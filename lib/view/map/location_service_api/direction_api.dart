import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialcarpooling/model/directionResponseApi.dart';
import 'package:socialcarpooling/util/CPString.dart';

class DirectionApiRepository {
  static const String baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio? _dio;

  DirectionApiRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<DirectionResponseApi> getDirection(
      {required LatLng origin, required LatLng destination}) async {

    final response = await _dio?.get(baseUrl,queryParameters: {
      'origin':'${origin.latitude},${origin.longitude}',
      'destination':'${destination.latitude},${destination.longitude}',
      'key':CPString.apiKey
    });

    if(response!.statusCode==200)
      {
        return DirectionResponseApi.fromJson(response.data);
      }

    return null!;
  }
}
