import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'location_model.dart';

class LocationService {
  final DatabaseReference _locationsRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://apb-gmaps-default-rtdb.asia-southeast1.firebasedatabase.app',
  ).ref('locations');

  Stream<List<LocationModel>> watchLocations() {
    return _locationsRef.onValue.map((event) {
      final value = event.snapshot.value;

      if (value == null) {
        return <LocationModel>[];
      }

      final data = Map<dynamic, dynamic>.from(value as Map);

      return data.entries.map((entry) {
        final id = entry.key.toString();
        final item = Map<dynamic, dynamic>.from(entry.value as Map);
        return LocationModel.fromMap(id, item);
      }).toList();
    });
  }

  Future<void> saveLocation(LocationModel location) async {
    await _locationsRef.child(location.id).set(location.toMap());
  }

  Future<void> resetDefaultLocationsToSurabaya() async {
    final Map<String, Object?> updates = {
      'telkom_university_surabaya': {
        'label': 'Telkom University Surabaya',
        'lat': -7.3096905,
        'lng': 112.7282377,
      },
    };

    await _locationsRef.update(updates);
  }
}
