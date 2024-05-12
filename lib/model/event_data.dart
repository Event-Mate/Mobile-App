import 'package:equatable/equatable.dart';
import 'package:event_mate/model/location_data.dart';
import 'package:kt_dart/kt.dart';

class EventData extends Equatable {
  const EventData({
    required this.id,
    required this.title,
    required this.info,
    required this.imageUrl,
    required this.price,
    required this.location,
    required this.category,
    required this.attending,
    required this.participantIds,
  });

  factory EventData.fromMap(Map<String, dynamic> map) {
    return EventData(
      id: map['_id'] as String,
      title: map['title'] as String,
      info: map['info'] as String,
      imageUrl: map['image'] as String,
      price: map['price'] as String,
      location: LocationData.fromMap(map['location'] as Map<String, dynamic>),
      category: map['category'] as String,
      attending: map['attending'] as bool? ?? false,
      participantIds: (map['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toImmutableList(),
    );
  }

  final String id;
  final String title;
  final String info;
  final String imageUrl;
  final String price;
  final LocationData location;
  final String category;
  final bool attending;
  final KtList<String> participantIds;

  String get dateTime => info.split("\n")[1];
  String get date => dateTime.split("-")[0];
  String get time => dateTime.split("- ")[1];
  String get place => location.name;

  @override
  List<Object?> get props => [
        id,
        title,
        info,
        imageUrl,
        price,
        location,
        date,
        time,
        category,
        attending,
        participantIds,
      ];
}
