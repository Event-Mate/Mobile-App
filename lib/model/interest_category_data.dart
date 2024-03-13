import 'package:equatable/equatable.dart';

class InterestCategoryData extends Equatable {
  const InterestCategoryData({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory InterestCategoryData.fromMap(Map<String, dynamic> map) {
    return InterestCategoryData(
      id: map['_id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  final String id;
  final String title;
  final String imageUrl;

  @override
  List<Object> get props => [id, title, imageUrl];
}
