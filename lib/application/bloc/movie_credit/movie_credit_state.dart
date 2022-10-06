//Project imports:
part of 'movie_credit_bloc.dart';

//MovieCreditState: Here we define the states of the MovieCreditBloc.
abstract class MovieCreditState {}

class MovieCreditStateInitial extends MovieCreditState {}

class MovieCreditStateLoading extends MovieCreditState {}

class MovieCreditStateHideLoading extends MovieCreditState {}



