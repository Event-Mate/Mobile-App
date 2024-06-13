part of 'social_posts_bloc.dart';

sealed class SocialPostsEvent extends Equatable {
  const SocialPostsEvent();

  @override
  List<Object> get props => [];
}

class _FetchAllPosts extends SocialPostsEvent {
  const _FetchAllPosts();
}

class _CreatePost extends SocialPostsEvent {
  const _CreatePost({required this.content, required this.eventData});

  final String content;
  final EventData eventData;

  @override
  List<Object> get props => [content, eventData];
}
