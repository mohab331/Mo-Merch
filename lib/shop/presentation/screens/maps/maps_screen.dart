import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

// Class to display a map and allow the user to select a location.
class MapsScreen extends StatefulWidget {
  const MapsScreen({
    this.onLocationSaved,
    this.initialLatitude,
    this.initialLongitude,
    Key? key,
  }) : super(key: key);

  static const String routeName = 'MapsScreen';
  static const String routePath = '/MapsScreen';

  final double? initialLatitude;
  final double? initialLongitude;
  final Function(LocationInfo?)? onLocationSaved;

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  Set<Marker> _markers = <Marker>{};
  LocationInfo? _locationToSave;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _showInitialLocationMarker();
    } else {
      _checkLocationPermissionAndGetCurrentLocation();
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              key: UniqueKey(),
              initialCameraPosition: _initialCameraPosition(
                markerLatLng: _markers.isEmpty ? null : _markers.first.position,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
              },
              onTap: _onMapTap,
              markers: _markers,
              myLocationEnabled: _shouldEnableInteractions(),
              zoomGesturesEnabled: _shouldEnableInteractions(),
              rotateGesturesEnabled: _shouldEnableInteractions(),
              zoomControlsEnabled: _shouldEnableInteractions(),
              scrollGesturesEnabled: _shouldEnableInteractions(),
              tiltGesturesEnabled: _shouldEnableInteractions(),
              myLocationButtonEnabled: _shouldEnableInteractions(),
              trafficEnabled: true,
            ),
          ),
          if(widget.initialLatitude == null || widget.initialLongitude == null)
            CustomElevatedButton(
              label: 'Save',
              onButtonPressed: (context) => _getLocationToSave(),
            ),
        ],
      ),
    );
  }

  // Check location permission and get the current location.
  void _checkLocationPermissionAndGetCurrentLocation() async {
    final locationPermissionStatus = await Permission.locationWhenInUse.status;
    if (locationPermissionStatus.isGranted) {
      _getCurrentLocation();
    } else if (locationPermissionStatus.isDenied) {
      final status = await Permission.location.request();
      if (status.isGranted) {
        _getCurrentLocation();
      } else {
        Navigator.pop(context);
      }
    }
  }

  // Get the current user's location using Geolocator.
  void _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _currentLocation = LatLng(position.latitude, position.longitude);
      final address = await _getAddressData(_currentLocation);
      _locationToSave = LocationInfo(
        title: 'current_location',
        address: address,
        latLng: _currentLocation,
      );
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
    }
  }

  // Show the initial location marker on the map.
  void _showInitialLocationMarker() {
    _currentLocation =
        LatLng(widget.initialLatitude!, widget.initialLongitude!);
    _markers.add(
      Marker(
        markerId: const MarkerId('initial_location'),
        position: _currentLocation!,
        infoWindow: const InfoWindow(title: 'Address Location'),
      ),
    );
  }

  // Add a marker to the map at the specified location.
  void _addMarker(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('tapped_location'),
          position: latLng,
          infoWindow: InfoWindow(
            title: 'Tapped Location',
            snippet:
                'Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}',
          ),
        ),
      );
    });
  }

  Future<Placemark?> _getAddressData(LatLng? latLng) async {
    if (latLng == null) return null;
    try {
      final response = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      return response.first;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting address data: $e');
      }
      return null; // Return null to indicate that address data couldn't be fetched.
    }
  }

// Handle a tap on the map, adding a marker and showing location information.
  void _onMapTap(LatLng latLng) {
    if (_shouldEnableInteractions() == false) return;
    _addMarker(latLng);
    _showLocationInfoBottomSheet(latLng);
  }

// Check if map interactions should be enabled.
  bool _shouldEnableInteractions() {
    return (widget.initialLatitude == null && widget.initialLongitude == null);
  }

// Show a bottom sheet with location information for the tapped marker.
  void _showLocationInfoBottomSheet(LatLng latLng) async {
    if (_markers.isEmpty) return; // No markers, nothing to show
    // Close any existing modal bottom sheet
    final response = await _getAddressData(latLng);
    final locationInfo = LocationInfo(
      title: 'tapped_location',
      latLng: latLng,
      address: response,
    );
    R.functions.showBottomSheet(
      context,
      MapsModalBottomSheet(
        location: locationInfo,
        onSaveTapped: (location) {
          _locationToSave = location;
        },
      ),
    );
  }

// Calculate the initial camera position for the map.
  CameraPosition _initialCameraPosition({LatLng? markerLatLng}) {
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      return CameraPosition(
        target: _currentLocation!,
        zoom: 17.0,
      );
    } else {
      return CameraPosition(
        target: markerLatLng ?? _currentLocation ?? const LatLng(0.0, 0.0),
        zoom: 30.0,
      );
    }
  }

// Get the location to be saved and notify the parent widget.
  void _getLocationToSave() {
    widget.onLocationSaved?.call(_locationToSave);
    Navigator.of(context).pop();
  }
}
