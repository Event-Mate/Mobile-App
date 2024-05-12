import 'package:equatable/equatable.dart';

class LocationData extends Equatable {
  const LocationData({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationData.fromMap(Map<String, dynamic> map) {
    final coords = (map['coords'] as List<dynamic>).cast<double>();
    return LocationData(
      id: map['_id'] as String,
      name: map['name'] as String,
      latitude: coords[0],
      longitude: coords[1],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'coords': [latitude, longitude],
    };
  }

  final String id;
  final String name;
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
      ];
}
