import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:gohealth/src/app/home/maps/marker_data.dart';
import 'package:gohealth/src/components/header_bar.dart';
import 'package:gohealth/src/components/side_menu.dart';
import 'package:latlong2/latlong.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

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

  void _addMarker(LatLng position, String title, String description) {
    setState(() {
      final markerData = MarkerData(
        position: position,
        title: title,
        description: description,
      );
      _markersData.add(markerData);
      _markers.add(Marker(
          point: position,
          width: 80,
          height: 80,
          child: GestureDetector(
            onTap: () {
              print('Marcador clicado');
            },
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(Icons.location_on, color: Colors.red),
            ]),
          )));
    });
  }

  // show marker dialog
  void _showMarkerDialog(BuildContext context, LatLng position) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Adicionar marcador',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    _addMarker(
                        position, titleController.text, descController.text);
                    Navigator.pop(context);
                  },
                  child: Text('Salvar'),
                ),
              ],
            ));
  }

  // show marker info when tapped

  void _showMarkerInfo(MarkerData markerdata) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(markerdata.title),
              content: Text(markerdata.description),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Fechar'),
                ),
              ],
            ));
  }

  // search future

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
    setState(() {
      _selectedPosition = location;
      _searchResults = [];
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
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
              onTap: (tapPosition, point) => {
                _selectedPosition = point,
                _draggedPosition = _selectedPosition,
              },
            ),
            mapController: _mapController,
            children: [
              TileLayer(
                urlTemplate: 'http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga',
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
                      )
                  )
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
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _showCurrentLocation();
                  },
                  child: Icon(Icons.location_searching_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
