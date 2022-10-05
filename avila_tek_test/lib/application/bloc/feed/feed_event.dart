//Project imports:
part of 'feed_bloc.dart';

///FeedEvent: Here we define the events of the FeedBloc.
abstract class FeedEvent {}


class FeedEventFetchBasicData extends FeedEvent {}

class FeedEventNavigateToWith extends FeedEvent {
  final String routeName;
  final Object? arguments;
  FeedEventNavigateToWith(this.routeName, this.arguments);

}