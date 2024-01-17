import 'package:bloc/bloc.dart';
import 'package:calibrar_activity/logic/database/database_service.dart';
import 'package:calibrar_activity/logic/model/reddit_model.dart';
import 'package:equatable/equatable.dart';

part 'reddit_form_event.dart';
part 'reddit_form_state.dart';

class RedditFormBloc extends Bloc<RedditFormEvent, RedditFormState> {
  RedditFormBloc() : super(RedditFormInitial()) {
    List<RedditModel> redditModelList = [];

    on<AddRedditPost>((event, emit) async {
      await DatabaseService.instance.create(
        RedditModel(
          id: event.id,
          title: event.title, 
          subtitle: event.subtitle,
          date: event.date,
          isDeleted: event.isDeleted,
        )
      );
    });

    on<UpdateRedditPost>((event, emit) async {
      await DatabaseService.instance.update(
        redditModel: event.redditModel,
      );
    });

    on<FetchRedditPosts>((event, emit) async {
      redditModelList = await DatabaseService.instance.readAllRedditPosts();
      emit(DisplayRedditPost(data: redditModelList));
    });

    on<FetchSpecificRedditPost>((event, emit) async {
      RedditModel redditModel = await DatabaseService.instance.readRedditPost(id: event.id);
      emit(DisplaySpecificRedditPost(data: redditModel));
    });

    on<DeleteRedditPost>((event, emit) async {
      await DatabaseService.instance.delete(id: event.id);
      add(const FetchRedditPosts());
    });
  }
}