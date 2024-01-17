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
    required this.place,
    required this.date,
    required this.time,
    required this.category,
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
      // TODO(Furkan): Remove these hardcoded values
      place: "Küçükçiftlik Park - İstanbul",
      date: "12 Ağustos Cmt",
      time: "20:30",
      // place: map['place'] as String,
      // date: map['date'] as String,
      // time: map['time'] as String,
      category: map['category'] as String,
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
  final String place;
  final String date;
  final String time;
  final String category;
  final KtList<String> participantIds;

  @override
  List<Object?> get props => [
        id,
        title,
        info,
        imageUrl,
        price,
        location,
        place,
        date,
        time,
        category,
        participantIds,
      ];
}
