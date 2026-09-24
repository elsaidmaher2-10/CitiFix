import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:citifix/core/service/LocationService.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/Animatedmarker.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:lottie/lottie.dart' hide Marker;

class CustomMap extends StatefulWidget {
  final Function(String street, LatLng latlng) onmapCreated;
  final LatLng? initialPosition;
  final String? initialStreet;
  final bool allowSelection;

  const CustomMap.fromDevice({
    super.key,
    required this.onmapCreated,
    this.allowSelection = false,
  }) : initialPosition = null,
       initialStreet = null;

  const CustomMap.fromAPI({
    super.key,
    required this.onmapCreated,
    required LatLng apiPosition,
    required String location,
    this.allowSelection = false,
  }) : initialPosition = apiPosition,
       initialStreet = location;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final Locationservice _locationservice = Locationservice();
  final TextEditingController _searchController = TextEditingController();

  LatLng? _currentPosition;
  String _street = "";
  bool _isLoading = true;
  bool _mapReady = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _street = widget.initialStreet ?? "";
    _searchController.addListener(_onSearchTextChanged);
    _initLocation();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initLocation() async {
    try {
      LatLng? targetPosition;

      if (widget.initialPosition != null) {
        targetPosition = widget.initialPosition;
      } else {
        final isReady = await _locationservice.init();
        if (isReady) {
          LocationData? newLocation = await _locationservice.getLocationOce();
          if (newLocation != null) {
            targetPosition = LatLng(
              newLocation.latitude!,
              newLocation.longitude!,
            );
          }
        }
      }

      targetPosition ??= const LatLng(31.4106, 31.8159);

      if (mounted) {
        await _setSelectedPosition(
          targetPosition,
          street: widget.initialStreet,
          updateSearchText: widget.allowSelection,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<String> _resolveStreet(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final resolvedStreet =
            "${place.street ?? ''} ${place.subAdministrativeArea ?? ''}".trim();
        if (resolvedStreet.isNotEmpty) {
          return resolvedStreet;
        }
      }
    } catch (e) {
      return "Unknown location";
    }

    return "Unknown location";
  }

  Future<void> _setSelectedPosition(
    LatLng position, {
    String? street,
    bool updateSearchText = false,
  }) async {
    final resolvedStreet = street ?? await _resolveStreet(position);

    if (!mounted) {
      return;
    }

    setState(() {
      _currentPosition = position;
      _street = resolvedStreet;
      _isLoading = false;
    });

    if (updateSearchText) {
      _searchController.text = resolvedStreet;
    }

    if (_mapReady) {
      _mapController.move(position, 14);
    }

    widget.onmapCreated(resolvedStreet, position);
  }

  Future<void> _searchLocation(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      return;
    }

    if (mounted) {
      setState(() => _isSearching = true);
    }

    try {
      final results = await locationFromAddress(trimmedQuery);
      if (results.isEmpty) {
        throw Exception(S.of(context).locationNotFound);
      }

      final selectedResult = results.first;
      await _setSelectedPosition(
        LatLng(selectedResult.latitude, selectedResult.longitude),
        updateSearchText: true,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).locationSearchFailed)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.allowSelection) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ScreenUtilsManager.w12),
              color: context.palette.surfaceContainerLow,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: _searchLocation,
                      decoration: InputDecoration(
                        hintText: S.of(context).searchLocationHint,
                        prefixIcon: Icon(
                          Icons.search,
                          color: context.palette.onSurfaceVariant,
                        ),
                        suffixIcon: _searchController.text.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: context.palette.onSurfaceVariant,
                                ),
                              ),
                        filled: true,
                        fillColor: context.palette.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenUtilsManager.w10),
                  _isSearching
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: context.palette.kPrimary,
                          ),
                        )
                      : IconButton(
                          onPressed: () =>
                              _searchLocation(_searchController.text),
                          icon: Icon(
                            Icons.my_location,
                            color: context.palette.kPrimary,
                          ),
                        ),
                ],
              ),
            ),
          ],
          SizedBox(
            height: ScreenUtilsManager.h250,
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: context.palette.kPrimary,
                    ),
                  )
                : Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter:
                              _currentPosition ??
                              const LatLng(31.4106, 31.8159),
                          initialZoom: 14,
                          onMapReady: () {
                            _mapReady = true;
                            if (_currentPosition != null) {
                              _mapController.move(_currentPosition!, 14);
                            }
                          },
                          onTap: widget.allowSelection
                              ? (_, point) async {
                                  await _setSelectedPosition(
                                    point,
                                    updateSearchText: true,
                                  );
                                }
                              : null,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.citifix',
                            additionalOptions: {
                              'User-Agent':
                                  'CitifixApp/1.0 (contact: your-email@domain.com)',
                            },
                          ),
                          if (_currentPosition != null)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _currentPosition!,
                                  width: 50,
                                  height: 50,
                                  child: CustomLocationMarker(),
                                ),
                              ],
                            ),
                        ],
                      ),
                      if (widget.allowSelection)
                        Positioned(
                          left: 12,
                          right: 12,
                          bottom: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: context.palette.surface.withValues(alpha: 0.92),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              S.of(context).tapMapToChooseLocation,
                              style: GoogleFonts.cairo(
                                color: context.palette.onSurfaceVariant,
                                fontSize: ScreenUtilsManager.s12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
          if (_street.isNotEmpty) ...[
            SizedBox(height: ScreenUtilsManager.h10),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      context.palette.kPrimary,
                      BlendMode.srcIn,
                    ),
                    child: Lottie.asset(AssetValueManager.pinLocaation),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    _street,
                    style: GoogleFonts.cairo(
                      color: context.palette.onSurfaceVariant,
                      fontSize: ScreenUtilsManager.s14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
