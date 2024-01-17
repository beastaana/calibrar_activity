part of 'reddit_form_bloc.dart';

sealed class RedditFormEvent extends Equatable {
  const RedditFormEvent();

  @override
  List<Object> get props => [];
}

class AddRedditPost extends RedditFormEvent {

  final int id;
  final String title;
  final String subtitle;
  final String date;
  final bool isDeleted;

  const AddRedditPost(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.isDeleted});

  @override
  List<Object> get props => [id, title, subtitle, date, isDeleted];
}

class UpdateRedditPost extends RedditFormEvent {
  
  final RedditModel redditModel;
  const UpdateRedditPost({required this.redditModel});

  @override
  List<Object> get props => [redditModel];
}

class FetchRedditPosts extends RedditFormEvent {

  const FetchRedditPosts();

  @override
  List<Object> get props => [];
}

class FetchSpecificRedditPost extends RedditFormEvent {

  final int id;
  const FetchSpecificRedditPost({required this.id});

  @override
  List<Object> get props => [id];
}

class DeleteRedditPost extends RedditFormEvent {

  final int id;
  const DeleteRedditPost({required this.id});

  @override
  List<Object> get props => [id];
}