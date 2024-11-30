import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:gohealth/src/app/home/maps/marker_data.dart';
import 'package:gohealth/src/components/header_bar.dart';
import 'package:gohealth/src/components/side_menu.dart';
import 'package:latlong2/latlong.dart';

import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatefulWidget {
  final String? query;

  const MapsPage({Key? key, this.query}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final MapController _mapController = MapController();

  List<MarkerData> _markersData = [];
  List<Marker> _markers = [];

  LatLng? _selectedPosition;
  LatLng? _mylocation;
  LatLng? _draggedPosition;
  Marker? _searchMarker;

  Timer? _debounce;

  bool _isDragging = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  List<dynamic> _searchResults = [];
  bool _isSearching = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Localização está desativada.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Localização está desativada. Por favor, habilite a localização nas configurações do dispositivo');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Localização está desativada.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  void _showCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      LatLng currentLocation = LatLng(position.latitude, position.longitude);
      _mapController.move(currentLocation, 15.0);
      setState(() {
        _mylocation = currentLocation;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';

    final response = await HttpClient().client.get(url);
    final data = response.data;

    if (data.isNotEmpty) {
      setState(() {
        _searchResults = data;
      });
    
      // If this was triggered by initial query parameter, move to first result
      if (widget.query != null && widget.query == query) {
        _moveToLocation(
            double.parse(data[0]['lat']), double.parse(data[0]['lon']));
        setState(() {
          _isSearching = false;
        });
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }
  // move to specific location

void _moveToLocation(double lat, double lng) {
    final location = LatLng(lat, lng);
    _mapController.move(location, 18.0);
  
    // Create new marker
    setState(() {
      _selectedPosition = location;
      _searchResults = [];
      _searchController.clear();
    
      // Remove previous search marker if exists
      if (_searchMarker != null) {
        _markers.remove(_searchMarker);
      }

      // Create new marker
      _searchMarker = Marker(
          point: location,
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 25,
            ),
          ));

      // Add new marker to list
      _markers.add(_searchMarker!);
    });
  }

  void _navigateToGoogleMaps() async {
    if (_searchMarker != null) {
      final lat = _searchMarker!.point.latitude;
      final lng = _searchMarker!.point.longitude;

      // For Android
      final androidUrl = Uri.parse('google.navigation:q=$lat,$lng&mode=d');
      // For iOS
      final iosUrl = Uri.parse(
          'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving');
      // Fallback for web or if native apps not installed
      final webUrl = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng');

      try {
        if (Platform.isAndroid && await canLaunchUrl(androidUrl)) {
          await launchUrl(androidUrl);
        } else if (Platform.isIOS && await canLaunchUrl(iosUrl)) {
          await launchUrl(iosUrl);
        } else if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch maps';
        }
      } catch (e) {
        debugPrint('Error launching maps: $e');
        // Show error to user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao abrir o Google Maps')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _showCurrentLocation();

    if (widget.query != null && widget.query!.isNotEmpty) {
      _searchController.text = widget.query!;
      _searchPlaces(widget.query!);
      // Reduce debounce time for initial search
      _debounce = Timer(const Duration(milliseconds: 500), () {
        _searchPlaces(widget.query!);
      });
    }

  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 5), () {
      _searchPlaces(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBarState(),
      drawer: SideMenu(),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: 13.0,
              initialCenter: _mylocation ?? LatLng(-23.5505, -46.6333),
              minZoom: 2.0,
              maxZoom: 18.0,
              keepAlive: true,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                scrollWheelVelocity: 0.005,
              ),
              onTap: (tapPosition, point) => {
                _selectedPosition = point,
                _draggedPosition = _selectedPosition,
              },
            ),
            mapController: _mapController,
            children: [
              TileLayer(
                urlTemplate:
                    'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga',
                userAgentPackageName: 'com.example.gohealth',
              ),
              RichAttributionWidget(
                // Include a stylish prebuilt attribution widget that meets all requirments
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () async => await HttpClient()
                        .client
                        .get('https://openstreetmap.org/copyright'),
                  ),
                  // Also add images...
                ],
              ),
              MarkerLayer(markers: _markers),
              if (_mylocation != null)
                MarkerLayer(markers: [
                  Marker(
                      point: _mylocation!,
                      width: 40,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.location_searching_rounded,
                          color: Colors.green,
                          size: 25,
                        ),
                      ))
                ]),
            ],
          ),
          // search widget
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (value) {
                      _searchPlaces(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Pesquisar lugares',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: _isSearching
                          ? IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchResults = [];
                                  _isSearching = false;
                                });
                              },
                            )
                          : null,
                    ),
                    onTap: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
                ),
                if (_isSearching && _searchResults.isNotEmpty)
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final result = _searchResults[index];
                          return ListTile(
                            title: Text(result['display_name']),
                            onTap: () {
                              _moveToLocation(double.parse(result['lat']),
                                  double.parse(result['lon']));
                            },
                          );
                        }),
                  )
              ],
            ),
          ),

// Update the Positioned FAB widget in build method
          Positioned(
            bottom: 50,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _navigateToGoogleMaps();
                  },
                  heroTag:
                      "locationButton", // Add unique tag to prevent hero animation conflicts
                  child: const Icon(Icons.location_searching_rounded),
                ),
                if (_searchMarker != null) ...[
                  const SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: _navigateToGoogleMaps,
                    backgroundColor: const Color.fromARGB(255, 200, 252, 201),
                    heroTag:
                        "navigationButton", // Add unique tag to prevent hero animation conflicts
                    child: const Icon(Icons.directions),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
