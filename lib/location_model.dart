class LocationModel {
  final String id;
  final String label;
  final double lat;
  final double lng;

  LocationModel({
    required this.id,
    required this.label,
    required this.lat,
    required this.lng,
  });

  factory LocationModel.fromMap(String id, Map<dynamic, dynamic> data) {
    return LocationModel(
      id: id,
      label: data['label']?.toString() ?? '',
      lat: (data['lat'] as num).toDouble(),
      lng: (data['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'label': label, 'lat': lat, 'lng': lng};
  }
}
