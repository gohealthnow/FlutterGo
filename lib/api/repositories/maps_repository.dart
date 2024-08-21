import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gohealth/api/services/http_client.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapsRepository {
  late HttpClient client;

  MapsRepository() {
    client = HttpClient();
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

  Future<void> _getCurrentLocation() async {
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
}
