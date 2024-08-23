import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gohealth/api/repositories/maps_repository.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final MapsRepository _repository = MapsRepository();

  @override
  void initState() {
    super.initState();
    _repository.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenStreetMap with Flutter'),
      ),
      body: _repository.currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _repository.mapController,
              options: MapOptions(
                initialCenter: LatLng(
                    _repository.currentLocation!.latitude!,
                    _repository.currentLocation!.longitude!),
                initialZoom: 15.0,
                onTap: (tapPosition, point) =>
                    _repository.addDestinationMarker(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: _repository.markers,
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _repository.routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_repository.currentLocation != null) {
            _repository.mapController.move(
              LatLng(_repository.currentLocation!.latitude!,
                  _repository.currentLocation!.longitude!),
              15.0,
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
