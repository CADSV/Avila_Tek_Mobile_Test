//Project imports:
part of 'feed_bloc.dart';

//FeedState: Here we define the states of the FeedBloc.
abstract class FeedState {}

class FeedStateInitial extends FeedState {}

class FeedStateLoading extends FeedState {}

class FeedStateHideLoading extends FeedState {}

class FeedStateError extends FeedState {}


