//Project imports:
part of 'movie_credit_bloc.dart';

///MovieCreditEvent: Here we define the events of the MovieCreditBloc.
abstract class MovieCreditEvent {}


class MovieCreditEventFetchBasicData extends MovieCreditEvent {
  final BuildContext context;
  final String movieId;
  MovieCreditEventFetchBasicData({required this.context, required this.movieId});
}

class MovieCreditEventNavigateTo extends MovieCreditEvent {
  final String routeName;
  final Object? arguments;
  MovieCreditEventNavigateTo(this.routeName, this.arguments);
}
