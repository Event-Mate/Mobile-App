part of 'social_posts_bloc.dart';

sealed class SocialPostsEvent extends Equatable {
  const SocialPostsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllPosts extends SocialPostsEvent {
  const FetchAllPosts();
}

class CreatePost extends SocialPostsEvent {
  const CreatePost({required this.content, required this.eventData});

  final String content;
  final EventData eventData;

  @override
  List<Object> get props => [content, eventData];
}
