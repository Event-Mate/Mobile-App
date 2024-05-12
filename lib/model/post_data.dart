import 'package:equatable/equatable.dart';
import 'package:event_mate/model/event_data.dart';
import 'package:event_mate/model/user_data.dart';

class PostData extends Equatable {
  const PostData({
    required this.userData,
    required this.eventData,
    required this.content,
  });

  factory PostData.fromMap(Map<String, dynamic> map) {
    return PostData(
      userData: UserData.fromMap(map['creator'] as Map<String, dynamic>),
      eventData: EventData.fromMap(map['event'] as Map<String, dynamic>),
      content: map['content'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creator': userData.toMap(),
      'event': eventData.toMap(),
      'content': content,
    };
  }

  final UserData userData;
  final EventData eventData;
  final String content;

  @override
  List<Object?> get props => [userData, eventData, content];
}
