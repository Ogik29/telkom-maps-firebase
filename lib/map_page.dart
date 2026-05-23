import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'location_model.dart';
import 'location_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationService _locationService = LocationService();
  final Completer<GoogleMapController> _controller = Completer();

  StreamSubscription<List<LocationModel>>? _locationSubscription;

  Set<Marker> _markers = {};

  static const LatLng _telkomUniversitySurabaya = LatLng(
    -7.3096905,
    112.7282377,
  );

  static const LatLng _jalanTunjunganSurabaya = LatLng(-7.25905, 112.73889);

  @override
  void initState() {
    super.initState();

    _listenLocations();
    _setupInitialMarker();
  }

  void _listenLocations() {
    _locationSubscription = _locationService.watchLocations().listen(
      (locations) {
        if (!mounted) return;

        setState(() {
          _markers = locations.map((location) {
            return Marker(
              markerId: MarkerId(location.id),
              position: LatLng(location.lat, location.lng),
              infoWindow: InfoWindow(title: location.label),
            );
          }).toSet();
        });
      },
      onError: (error) {
        debugPrint('Gagal membaca lokasi dari Firebase: $error');
      },
    );
  }

  Future<void> _setupInitialMarker() async {
    try {
      await _locationService.resetDefaultLocationsToSurabaya();
    } catch (e) {
      debugPrint('Gagal membuat marker awal: $e');
    }
  }

  Future<void> _moveCameraTo(LatLng target) async {
    final GoogleMapController mapController = await _controller.future;

    await mapController.animateCamera(CameraUpdate.newLatLngZoom(target, 17));
  }

  Future<void> _goToTelkomUniversitySurabaya() async {
    final telkom = LocationModel(
      id: 'telkom_university_surabaya',
      label: 'Telkom University Surabaya',
      lat: _telkomUniversitySurabaya.latitude,
      lng: _telkomUniversitySurabaya.longitude,
    );

    await _locationService.saveLocation(telkom);
    await _moveCameraTo(_telkomUniversitySurabaya);
  }

  Future<void> _goToJalanTunjunganSurabaya() async {
    final tunjungan = LocationModel(
      id: 'jalan_tunjungan_surabaya',
      label: 'Jalan Tunjungan Surabaya',
      lat: _jalanTunjunganSurabaya.latitude,
      lng: _jalanTunjunganSurabaya.longitude,
    );

    await _locationService.saveLocation(tunjungan);
    await _moveCameraTo(_jalanTunjunganSurabaya);
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _telkomUniversitySurabaya,
          zoom: 17,
        ),
        markers: _markers,
        mapType: MapType.normal,

        // Tombol + dan - bawaan Google Maps dimatikan
        // supaya tidak bertumpuk dengan tombol buatan kita.
        zoomControlsEnabled: false,

        myLocationButtonEnabled: false,
        compassEnabled: true,

        // Memberi ruang bawah supaya tombol tidak menutupi area map.
        padding: const EdgeInsets.only(bottom: 150),

        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
      ),

      // Tombol dipindah ke bawah tengah
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              heroTag: 'btn_tunjungan',
              onPressed: _goToJalanTunjunganSurabaya,
              icon: const Icon(Icons.flag),
              label: const Text('Ke Tunjungan'),
            ),
            const SizedBox(height: 12),
            FloatingActionButton.extended(
              heroTag: 'btn_telkom_surabaya',
              onPressed: _goToTelkomUniversitySurabaya,
              icon: const Icon(Icons.school),
              label: const Text('Ke Tel-U Surabaya'),
            ),
          ],
        ),
      ),
    );
  }
}
