import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:gohealth/src/app/maps/maps_page.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapsRepository extends State<MapScreen> {
  late HttpClient client;

  LocationData? currentLocation;
  List<LatLng> routePoints = [];
  List<Marker> markers = [];
  final String orsApiKey =
      '5b3ce3597851110001cf62482a3bbccce840449baea616641f870310';

  final MapController mapController = MapController();

  MapsRepository() {
    client = HttpClient();
  }

  Future<void> getCurrentLocation() async {
    var location = Location();

    try {
      var userLocation = await location.getLocation();
      setState(() {
        currentLocation = userLocation;
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(userLocation.latitude!, userLocation.longitude!),
            child:
                const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
          ),
        );
      });
    } on Exception {
      currentLocation = null;
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        currentLocation = newLocation;
      });
    });
  }

  Future<void> getRoute(LatLng destination, LocationData? currentLocation,
      List<LatLng> routePoints, List<Marker> markers) async {
    if (currentLocation == null) return;

    final start = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    const orsApiKey = 'YOUR_API_KEY';
    final response = await client.client.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'
              .toString()) as String,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      routePoints = coords.map((coord) => LatLng(coord[1], coord[0])).toList();
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: destination,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    } else {
      // Handle errors
      print('Failed to fetch route');
    }
  }

  void addDestinationMarker(LatLng point) {
    setState(() {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    });
    getRoute(point, currentLocation, routePoints, markers);
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
