//Project imports:
part of 'movie_credit_bloc.dart';

///MovieCreditEvent: Here we define the events of the MovieCreditBloc.
abstract class MovieCreditEvent {}


class MovieCreditEventFetchBasicData extends MovieCreditEvent {
  final BuildContext context;
  MovieCreditEventFetchBasicData({required this.context});
}

class MovieCreditEventNavigateToWith extends MovieCreditEvent {
  final String routeName;
  final Object? arguments;
  MovieCreditEventNavigateToWith(this.routeName, this.arguments);
}
