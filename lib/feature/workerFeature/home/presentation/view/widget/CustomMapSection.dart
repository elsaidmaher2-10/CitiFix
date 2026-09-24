import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_cubit.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_state.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:geo_fence_utils/models/geo_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' hide Marker;

class CustomMapSection extends StatefulWidget {
  final LatLng? taskLocation;
  final String areaname;
  final List<LatLng> zonemLevel;

  CustomMapSection({
    super.key,
    this.taskLocation,
    required this.areaname,
    required this.zonemLevel,
  });

  @override
  State<CustomMapSection> createState() => _CustomMapSectionState();
}

class _CustomMapSectionState extends State<CustomMapSection> {
  final MapController _mapController = MapController();
  bool _mapReady = false;
  LatLng? _currLocation;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapControllerCubit(),
      child: BlocConsumer<MapControllerCubit, MapControllerState>(
        listener: (context, state) {
          if (_mapReady) {
            if (state is WorkerOutSideZone) {
              _currLocation = state.curpoint;
              List<LatLng> allPoints = [
                _currLocation!,
                if (widget.taskLocation != null) widget.taskLocation!,
                ...widget.zonemLevel,
                ...state.routePoints,
              ];

              if (allPoints.length >= 2) {
                final bounds = LatLngBounds.fromPoints(allPoints);
                _mapController.fitCamera(
                  CameraFit.bounds(
                    bounds: bounds,
                    padding: EdgeInsets.all(ScreenUtilsManager.s70),
                  ),
                );
              }
            } else if (state is WorkerInsideZone) {
              _currLocation = state.curlocation;
              _mapController.move(_currLocation!, ScreenUtilsManager.s17);
            } else if (state is WorkerNoZone) {
              _currLocation = state.curlocation;
              _mapController.move(_currLocation!, ScreenUtilsManager.s17);
            }
          }
        },
        builder: (context, state) {
          if (state is WorkerNoZone) {
            _currLocation = state.curlocation;
          }

          String distanceValue = "0.0";
          if (state is WorkerOutSideZone) {
            distanceValue = (state.distance / 1000).toStringAsFixed(1);
          }

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: ScreenUtilsManager.h320,
                    decoration: BoxDecoration(
                      color: context.palette.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r24,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter:
                            widget.taskLocation ??
                            (widget.zonemLevel.isNotEmpty
                                ? widget.zonemLevel.first
                                : LatLng(30.0444, 31.2357)),
                        initialZoom: ScreenUtilsManager.s14,
                        onMapReady: () {
                          setState(() => _mapReady = true);
                          context.read<MapControllerCubit>().trackUserLocation(
                            points: widget.zonemLevel.length >= 3
                                ? widget.zonemLevel
                                      .map(
                                        (e) => GeoPoint(
                                          latitude: e.latitude,
                                          longitude: e.longitude,
                                        ),
                                      )
                                      .toList()
                                : [],
                          );
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.globalgate.worker',
                        ),
                        if (state is WorkerOutSideZone &&
                            state.routePoints.isNotEmpty)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: state.routePoints,
                                strokeWidth: ScreenUtilsManager.s5,
                                color: context.palette.workerprimary,
                                borderStrokeWidth: ScreenUtilsManager.s2,
                                borderColor: Colors.white,
                              ),
                            ],
                          ),
                        if (widget.zonemLevel.length >= 3)
                          PolygonLayer(
                            polygons: [
                              Polygon(
                                points: widget.zonemLevel,
                                color: context.palette.workerprimary.withValues(alpha: 0.12),
                                borderColor: context.palette.workerprimary,
                                borderStrokeWidth: ScreenUtilsManager.s2,
                              ),
                            ],
                          ),
                        MarkerLayer(
                          markers: [
                            if (widget.taskLocation != null)
                              Marker(
                                point: widget.taskLocation!,
                                width: ScreenUtilsManager.s50,
                                height: ScreenUtilsManager.s50,
                                child: Icon(
                                  Icons.location_on_rounded,
                                  color: context.palette.onSurfaceVariant,
                                  size: ScreenUtilsManager.s45,
                                ),
                              ),
                            if (_currLocation != null)
                              Marker(
                                point: _currLocation!,
                                width: ScreenUtilsManager.s65,
                                height: ScreenUtilsManager.s65,
                                child: Lottie.asset(AssetValueManager.location),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (state is WorkerOutSideZone && widget.taskLocation != null)
                    Positioned(
                      top: ScreenUtilsManager.s20,
                      left: ScreenUtilsManager.s20,
                      right: ScreenUtilsManager.s20,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtilsManager.s12,
                          horizontal: ScreenUtilsManager.s20,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context.palette.workerprimary,
                              context.palette.workerprimary.withValues(alpha: 0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            ScreenUtilsManager.s16,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.palette.workerprimary.withValues(alpha: 0.3),
                              blurRadius: ScreenUtilsManager.s12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).distance_to_task.toUpperCase(),
                                  style: GoogleFonts.cairo(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: ScreenUtilsManager.s10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  "$distanceValue ${S.of(context).km}",
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: ScreenUtilsManager.s20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(ScreenUtilsManager.w8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.directions_run_rounded,
                                color: Colors.white,
                                size: ScreenUtilsManager.icon24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  Positioned(
                    bottom: ScreenUtilsManager.s20,
                    right: ScreenUtilsManager.s20,
                    child: Column(
                      children: [
                        _MapButton(
                          icon: Icons.add_rounded,
                          onTap: () {
                            final currentZoom = _mapController.camera.zoom;
                            _mapController.move(
                              _mapController.camera.center,
                              currentZoom + 1,
                            );
                          },
                        ),
                        SizedBox(height: ScreenUtilsManager.s10),
                        _MapButton(
                          icon: Icons.remove_rounded,
                          onTap: () {
                            final currentZoom = _mapController.camera.zoom;
                            _mapController.move(
                              _mapController.camera.center,
                              currentZoom - 1,
                            );
                          },
                        ),
                        SizedBox(height: ScreenUtilsManager.s10),
                        _MapButton(
                          icon: Icons.my_location_rounded,
                          onTap: () {
                            if (_currLocation != null) {
                              _mapController.move(
                                _currLocation!,
                                ScreenUtilsManager.s17,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(ScreenUtilsManager.s20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.w12),
                      decoration: BoxDecoration(
                        color: context.palette.workerprimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
                      ),
                      child: Icon(
                        Icons.my_location_rounded, 
                        color: context.palette.workerprimary,
                        size: ScreenUtilsManager.s26,
                      ),
                    ),
                    SizedBox(width: ScreenUtilsManager.w16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state is WorkerInsideZone
                                ? S.of(context).inside_work_zone
                                : state is WorkerNoZone
                                ? S.of(context).monitoring_area
                                : (widget.taskLocation != null
                                      ? S.of(context).heading_to_task
                                      : S.of(context).monitoring_area),
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.w800,
                              fontSize: ScreenUtilsManager.s18,
                              color: context.palette.onSurface,
                            ),
                          ),
                          Text(
                            widget.areaname,
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s14,
                              fontWeight: FontWeight.w600,
                              color: context.palette.onSurfaceVariant.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScreenUtilsManager.w44,
        height: ScreenUtilsManager.h44,
        decoration: BoxDecoration(
          color: context.palette.surface,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          border: Border.all(color: context.palette.outline.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: context.palette.shadow,
              blurRadius: ScreenUtilsManager.s8,
              offset: Offset(0, ScreenUtilsManager.h4),
            ),
          ],
        ),
        child: Icon(icon, color: context.palette.workerprimary, size: ScreenUtilsManager.icon24),
      ),
    );
  }
}
