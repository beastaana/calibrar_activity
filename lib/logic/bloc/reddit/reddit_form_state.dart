part of 'reddit_form_bloc.dart';

sealed class RedditFormState extends Equatable {
  const RedditFormState();
  
  @override
  List<Object> get props => [];
}

final class RedditFormInitial extends RedditFormState {
  
}

class DisplayRedditPost extends RedditFormState {

  final List<RedditModel> data; 
  const DisplayRedditPost({required this.data});

  @override
  List<Object> get props => [data];
}

class DisplaySpecificRedditPost extends RedditFormState {
  final RedditModel data; 
  const DisplaySpecificRedditPost({required this.data});
  
  @override
  List<Object> get props => [data];
}