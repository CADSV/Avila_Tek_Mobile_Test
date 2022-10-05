//Project imports:
part of 'feed_bloc.dart';

///FeedEvent: Here we define the events of the FeedBloc.
abstract class FeedEvent {}


class FeedEventFetchBasicData extends FeedEvent {
  final BuildContext context;
  FeedEventFetchBasicData({required this.context});
}

class FeedEventNavigateToWith extends FeedEvent {
  final String routeName;
  final Object? arguments;
  FeedEventNavigateToWith(this.routeName, this.arguments);
}

class FeedEventFetchMoreMovies extends FeedEvent {
  final List<MovieModel> oldMoviesList;
  final BuildContext context;
  FeedEventFetchMoreMovies(this.oldMoviesList, this.context);
}