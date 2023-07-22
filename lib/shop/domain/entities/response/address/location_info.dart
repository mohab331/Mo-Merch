import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInfo {
  const LocationInfo({
    required this.title,
    required this.latLng,
    this.address,
  });
  final String title;
  final LatLng? latLng;
  final Placemark? address;
}