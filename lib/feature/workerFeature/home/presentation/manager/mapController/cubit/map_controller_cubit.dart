import 'dart:async';
import 'package:citifix/core/service/LocationService.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_fence_utils/geo_fence_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:osrm/osrm.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapControllerInitial());

  final Locationservice _location = Locationservice();
  final Osrm _osrm = Osrm();
  StreamSubscription? _locationSubscription;

  Future<void> trackUserLocation({required List<GeoPoint> points}) async {
    await _locationSubscription?.cancel();

    final ready = await _location.init();
    if (!ready) {
      emit(
        MapControllerError(
          message: "Location permission denied or service disabled",
        ),
      );
      return;
    }

    _location.location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      interval: 10000,
    );

    _locationSubscription = _location.location.onLocationChanged.listen((
      onData,
    ) async {
      final lat = onData.latitude;
      final lng = onData.longitude;

      if (lat == null || lng == null) return;
      final curLocation = LatLng(lat, lng);
      if (points.length < 3) {
        emit(WorkerNoZone(curlocation: curLocation));
        return;
      }

      final isInside = insideZone(points: points, curLocation: curLocation);

      if (isInside) {
        emit(
          WorkerInsideZone(
            curlocation: curLocation,
            message: "You are inside the zone — you can work",
          ),
        );
      } else {
        final distance = calcDistance(
          GeoPoint(latitude: lat, longitude: lng),
          points,
        );

        final closest = getClosestPoints(
          center: GeoPoint(latitude: lat, longitude: lng),
          allPoints: points,
        );

        List<LatLng> routePoints = [];
        if (closest != null) {
          if (isClosed) return;
          routePoints = await getRoute(
            start: curLocation,
            end: LatLng(closest.latitude, closest.longitude),
          );
          if (isClosed) return;
        }

        emit(
          WorkerOutSideZone(
            curpoint: curLocation,
            message: "Distance to zone: ${distance.toStringAsFixed(1)} m",
            distance: distance,
            routePoints: routePoints,
          ),
        );
      }
    });
  }

  bool insideZone({
    required List<GeoPoint> points,
    required LatLng curLocation,
  }) {
    final polygon = GeoPolygon(points: points);
    return GeoPolygonService.isInsidePolygon(
      point: GeoPoint(
        latitude: curLocation.latitude,
        longitude: curLocation.longitude,
      ),
      polygon: polygon,
      includeBoundary: true,
    );
  }

  double calcDistance(GeoPoint origin, List<GeoPoint> destinations) {
    final distances = GeoDistanceService.calculateDistances(
      origin,
      destinations,
    );
    return distances.isNotEmpty ? distances[0] : 0.0;
  }

  GeoPoint? getClosestPoints({
    required GeoPoint center,
    required List<GeoPoint> allPoints,
  }) {
    return GeoDistanceService.findClosest(center, allPoints);
  }

  Future<List<LatLng>> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final response = await _osrm.route(
        RouteRequest(
          coordinates: [
            (start.longitude, start.latitude),
            (end.longitude, end.latitude),
          ],
          overview: OsrmOverview.full,
          steps: false,
        ),
      );

      if (response.routes.isEmpty) return [];

      final geometry = response.routes.first.geometry;
      if (geometry == null || geometry.lineString?.coordinates == null) {
        return [];
      }

      final coords = geometry.lineString!.coordinates;
      return coords.map<LatLng>((e) => LatLng(e.$2, e.$1)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> close() async {
    await _locationSubscription?.cancel();
    super.close();
  }
}
